import sqlite3
import MySQLdb

import lxml.html
from copy import deepcopy
import string

# -> to delete stuff from mysql
#delete from AdditionalImages;delete from ASIN_ISBN;delete from ContentDetails;delete from ContentSnippets;


class Utils:
    def __init__(self):
        pass

    def get_as_dictionary_list(self,connection,sql,params=()):
        query_result = connection.execute(sql,params)
        rows = []
        for row in query_result:
            rows.append(self.row_to_dictionary(query_result, row))
        return rows

    def row_to_dictionary(self,query_result,row):
        return {k[0]: v for k, v in list(zip(query_result.description, row))}


ALPHA_LITERAL = frozenset(string.ascii_letters + string.digits + '_' + '-')

# helpers
def isalphaliteral(mystring):
    return all(c in ALPHA_LITERAL for c in mystring)

def getFirstAlphaLiteral(text):
    for entry in text.split(" "):
        if len(entry) > 6 and isalphaliteral(entry):
            return entry
    return None

def prepare(record):
    if record['PageSnippet'] is not None:
        record["Snippet"] =   lxml.html.fromstring(record['PageSnippet'])
    else:
        record["Snippet"] = lxml.html.fromstring(record['RecordSnippet'])


# fiels for copy
def pageURL(record):
    return record['PageURL'][:64]

def recordId(record):
    return record['CS_ID']

def websiteId(record):
    return record['WebSiteID']

def categoryId(record):
    return record['CategoryID']


def publDate(record):
    return record['PublDate']

# field extractors
def extractMainHeader(record):

    snip = record["Snippet"]
    node = snip.xpath("//h1")
    if node is None or len(node) == 0:
        node = snip.xpath("//div[contains(@class, 'text-center')]/b")
    header = node[0].text

    is_repost = extractIsRepost(record)
    if is_repost and header is not None:
        header = header.replace("Repost","repost")\
            .replace("[repost]","").replace("[repost]","")\
            .replace("(repost)","").replace("(repost)","") \
            .replace("repost", "").replace("repost", "")

    if header is None:
        header = ""
    return header


def extractMainTitleFromHtmlBlockAsString(htmlCode):
    snip = lxml.html.fromstring(htmlCode)
    node = snip.xpath("//h4[contains(@class, 'modal-title')]")
    if node is None or len(node) == 0:
        node = snip.xpath("//div[contains(@class, 'text-center')]/b")
    header = node[0].text
    return header


def extractMainTitle(record):
    snip = record["Snippet"]
    node = snip.xpath("//h4[contains(@class, 'modal-title')]")
    if node is None or len(node) == 0:
        node = snip.xpath("//div[contains(@class, 'text-center')]/b")
    header = node[0].text
    return header


def extractYear(record):
    desc = extractSubTitleDescr(record)
    for entry in desc.split(" "):
        try:
            year = int(entry)
            if year < 1900 or year > 2017:
                continue
            return year
        except ValueError:
            pass


def extractISBN(record):
    snip = record["Snippet"]
    text = snip.text_content()
    pos = text.find("ISBN")
    isbns = []
    while pos >= 0:
        text = text[pos + 4:]
        pos = text.find("ISBN")
        isbn = getFirstAlphaLiteral(text)
        isbns.append(isbn)
    return isbns


def extractASIN(record):
    snip = record["Snippet"]
    text = snip.text_content()
    pos = text.find("ASIN")
    asins = []
    while pos >= 0:
        text = text[pos + 4:]
        asin = getFirstAlphaLiteral(text)
        asins.append(asin)
        pos = text.find("ASIN")
    return asins


def extractIsRepost(record):
    snip = record["Snippet"]
    text = snip.text_content()
    pos = text.find("Repost")
    if pos == -1:
        pos = text.find("repost")
    if pos == -1:
        return 'N'
    text = text[pos:]
    pos = text.find("Posted By")
    if pos == -1:
        return 'N'
    return 'Y'


def extractPages(record):
    snip = record["Snippet"]
    text = snip.text_content()
    pos = text.find("Pages")
    if pos == -1:
        pos = text.find("pages")
    if pos == -1:
        return None
    text = text[max(0,pos-20):pos + 5]
    #print(text)
    text = text.split(" ")[-2]
    try:
        return int(text)
    except ValueError:
        return None


def extractImages(record):
    snip = record["Snippet"]
    images = snip.xpath("//img")
    image_urls = []
    for image in images:
        image_urls.append(image.get('src'))
    return image_urls

def extractTitleImage(record):
    images = extractImages(record)
    for image in images:
        if image.find("_medium.jp") > -1:
            return image


# extract language from pirce of text. Example "German beer"-> id of "German"
def extractLanguageFromTextString(text):
    langsfound = []
    for langid, lang in langs.items():
        if lang is not None:
            pos = text.find(lang)
            if pos > -1:
                langsfound.append(langid)
    if len(langsfound) == 0:
        return NO_LANGUAGE_DETECTED
    if len(langsfound) == 1:
        return langsfound[0]
    return MULTILANGUAGE_DETECTED


# extract language from pirce of html passed as test "<h1><b>German</b>beer</h1>"-> id of "German"
def extractLanguageRaw(htmlBlockAsString):
    htmlTree = lxml.html.fromstring(htmlBlockAsString)
    pureText = htmlTree.text_content()
    return extractLanguageFromTextString(pureText)

# extract language from unit which represent raw record from sqlite db
def extractLanguage(record):
    snip = record["Snippet"]
    text = snip.text_content()
    return extractLanguageFromTextString(text)


def extractPlatform(record):
    snip = record["Snippet"]
    text = snip.text_content()
    platformsfound = set([])
    for platform_tag in platform_tags:
        pos = text.find(platform_tag)
        if pos > -1:
            platformsfound.add(platform_tags[platform_tag])
    if len(platformsfound) == 1:
        return platformsfound[0]
    return None


def extractAuthors(record):
    title = extractMainTitle(record)
    snip = record["Snippet"]
    btags = snip.xpath("//b")
    for item in btags:
        text = item.text_content()
        if title is not None and text != title and len(text) > len(title) and str(item.text_content()).startswith(title):
            authors = text[len(title):].strip()
            if authors.startswith("By") or authors.startswith("by"):
                authors = authors[3:]
                return authors

    words = title.split(" ")
    if "by" in words or "By" in words:
        for pos,word in enumerate(words):
            if word == "by" or word == "By":
                words = words[pos + 1:]
                authors = " ".join(words)
                return authors
    if "-" in words:
        for pos, word in enumerate(words):
            if word == "-":
                words = words[:pos]
                authors = " ".join(words)
                return authors


def extractDuration(record):
    snip = record["Snippet"]
    text = snip.text_content()
    pos = text.find("Duration")
    if pos == -1:
        return
    text = text[pos:]
    for word in text.split(" ")[0:3]:
        if ":" in word:
            for part in word.split(":"):
                if len(part) == 0:
                    break
                try:
                    num = int(part)
                except ValueError:
                    break
            else:
                return word
    return None


def extractSubTitleDescr(record):
    snip = record["Snippet"]
    divtags = snip.xpath("//div[contains(@class, 'text-center')]")
    if len(divtags) == 0:
        return None

    subTitle = None
    title = extractMainTitle(record)
    for divtag in divtags:
        text = divtag.text_content()
        if text.find(" | ") == -1:
            continue

        if text.find(title[0:10]) > -1:
            b = snip.xpath("//div[contains(@class, 'text-center')]/b")[0].text_content()
            subTitle = text.replace(b, b + " " )

    if subTitle is not None:
        lines = subTitle.split("\r\n")
        for line in lines:
            if line.find(" | ") > -1:
                line = line.replace("\t","")
                return line
    return None


def sanitize(text):
    text = text.replace("\r\n"," ").replace("\t"," ")
    while True:
        text1 = text.replace("  ", " ")
        if text1 == text:
            break
        text = text1
    return text


def extractContextDescr(record):
    if record["PageSnippet"] is None:
        return

    snip = deepcopy(record["Snippet"])
    textdivs = snip.xpath("//div[contains(@class, 'text')]")

    candidates = []
    for textdiv in textdivs:
        for item in textdiv:
            if item.tag == "div":
                textdiv.remove(item)
        candidates.append(textdiv)

    for textdiv in candidates:
        text = textdiv.text_content()
        text = sanitize(text)
        return text


def filterExternalLinks(snippet):
    snip = lxml.html.fromstring(snippet)
    download_links = snip.xpath("//div[contains(@class, 'text download_links')]")
    for tag in download_links:
        parent = tag.getparent()
        parent.remove(tag)

    textcenter_tags = snip.xpath("//div[contains(@class, 'text-center')]")
    for tag in textcenter_tags:
        if tag.text_content().find("avxhm.se"):
            parent = tag.getparent()
            parent.remove(tag)

    filtered = lxml.html.tostring(snip)
    return filtered

def pageSnippet(record):
    if record['PageSnippet'] is None:
        return None

    filtered = filterExternalLinks(record['PageSnippet'])
    return filtered[:8000]

def recordSnippet(record):
    if record['RecordSnippet'] is None:
        return None

    filtered = filterExternalLinks(record['RecordSnippet'])
    return filtered[:8000]


def extractApproxSize(record):
    subTitleDescr = extractSubTitleDescr(record)
    if subTitleDescr is None:
        return

    chunks = subTitleDescr.split("|")
    for item in chunks:
        #print("item",item)
        words = item.split(" ")
        for pos,word in enumerate(words):
            if word.upper() in ["KB","MB","GB","TB"] and pos > 0:
                return words[pos -1] + " " + words[pos]



# process record
def process_record(record):
    prepare(record)
    id = recordId(record)
    website = websiteId(record)
    category = categoryId(record)

    pubDate = publDate(record)

    url = pageURL(record)
    main_header = extractMainHeader(record)
    main_title = extractMainTitle(record)
    year = extractYear(record)
    isbn = extractISBN(record)
    asin = extractASIN(record)
    is_repost = extractIsRepost(record)
    pages = extractPages(record)
    images = extractImages(record)
    title_image = extractTitleImage(record)
    language = extractLanguage(record)
    platform = extractPlatform(record)
    authors = extractAuthors(record)
    duration = extractDuration(record)
    subTitleDescr = extractSubTitleDescr(record)
    approxSize = extractApproxSize(record)

    miscDescr = None

    rSnippet = recordSnippet(record)
    pSnippet = pageSnippet(record)
    contxtDescr = extractContextDescr(record)


    tvars = vars()
    del tvars["record"]
    return tvars


snippet_sql = "INSERT INTO ContentSnippets(CS_ID,WebSiteID,PageURL,CategoryID,RecordSnippet,PageSnippet,PublDate) VALUES(%s,%s,%s,%s,%s,%s,%s)"
detail_sql = "INSERT INTO ContentDetails(CS_ID,WebSiteID,PageURL,CategoryID,MainHeader,IsRepost,MainTitle,Authors,Year,LanguageID,PlatformTypeID,ASIN_ISBN,Pages,Duration,ApproxSize,TitleImagePath,ImageDownloaded,SubTitleData,ContentDescr,MiscDescr,IsNotCorrect) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
asinisbn_sql = "INSERT INTO ASIN_ISBN(CS_ID,Num,Type,Manual,ASIN_ISBN) VALUES(%s,%s,%s,%s,%s)"
image_sql = "INSERT INTO AdditionalImages(CS_ID,Num,ImageUrl,OrigImageName,FileExtension,ImageSize,IsDownloaded,NewImagename) VALUES(%s,%s,%s,%s,%s,%s,%s,%s)"

def prepare_sqls(parsed_record):
    sqls = []
    snippet_params = (
        parsed_record["id"], parsed_record["website"],
        parsed_record["url"], parsed_record["category"],
        parsed_record["rSnippet"], parsed_record["pSnippet"],
        parsed_record["pubDate"]
    )
    detail_params = (
        parsed_record["id"], parsed_record["website"],
        parsed_record["url"], parsed_record["category"],
        parsed_record["main_header"], parsed_record["is_repost"],
        parsed_record["main_title"], parsed_record["authors"],
        parsed_record["year"], parsed_record["language"],
        parsed_record["platform"], ",".join(parsed_record["asin"] + parsed_record["isbn"]),
        parsed_record["pages"], parsed_record["duration"],
        parsed_record["approxSize"], parsed_record["title_image"],
        'N', parsed_record["subTitleDescr"],
        parsed_record["contxtDescr"], None, 'C'
    )
    sqls.append({"sql": snippet_sql, "params": snippet_params,"action":"snippet_sql"})
    sqls.append({"sql": detail_sql, "params": detail_params,"action":"detail_sql"})

    num = 0
    for record in parsed_record["asin"]:
        num += 1
        asinisbn_params = (parsed_record["id"], num, 'A', 'F', record)
        sqls.append({"sql": asinisbn_sql, "params": asinisbn_params,"action":"asinisbn_sql"})

    for record in parsed_record["isbn"]:
        num += 1
        asinisbn_params = (parsed_record["id"], num, 'I', 'F', record)
        sqls.append({"sql": asinisbn_sql, "params": asinisbn_params,"action":"asinisbn_sql"})

    num = 0
    for record in parsed_record["images"]:
        num += 1
        image_params = (parsed_record["id"], num,record,'','',-1,'','')
        sqls.append({"sql": image_sql, "params": image_params, "action": "image_sql"})

    return sqls



utils = Utils()
con = sqlite3.connect('SCL_DB.db')
for item in utils.get_as_dictionary_list(con,"SELECT name FROM sqlite_master WHERE type='table';"):
    pass

# Prepare
langs = {}
langsquery = utils.get_as_dictionary_list(con,"SELECT * FROM Languages")
for lang in langsquery:
    langs[lang["LanguageID"]] = lang["LanguageName"]
NO_LANGUAGE_DETECTED = 0
MULTILANGUAGE_DETECTED = 9

platform_tags = {}
platform_tags["macOS"] = "A"
platform_tags["MacOSX"] = "A"
platform_tags["macos"] = "A"
platform_tags["Mac"] = "A"
platform_tags["OSX"] = "A"
platform_tags["Mac OS X"] = "A"

# Process Sqlite records
res = utils.get_as_dictionary_list(con,"SELECT * FROM ContentSnippets")
parsed_records = []
for record in res:
    parsed_data = process_record(record)
    parsed_records.append(parsed_data)


# Start saving to MsSQL
myqsql_connection = MySQLdb.connect(host="localhost", user="root", passwd="mySQLpapa6", db="mytest1", charset="utf8")
cursor = myqsql_connection.cursor()
for parsed_record in parsed_records:
    sqls = prepare_sqls(parsed_record)

    action = None
    try:
        for sql in sqls:
            action = sql["action"]
            cursor.execute(sql["sql"], sql["params"])
    except Exception as trouble:
        print("Trouble with:" ,parsed_record["id"], action,trouble)
    myqsql_connection.commit()

















