# -*- coding: utf-8 -*-
import sys
import codecs
from datetime import datetime

import requests
from bs4 import BeautifulSoup

import mysql

def now_string():
    date_string = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    return date_string


def get_detail(url):
    url = host + url
    r = requests.get(url)
    soup = BeautifulSoup(r.content, 'lxml')
    article = soup.find(attrs={"class":"col-md-12 article"})

    return article.prettify()


def crawl(url, qp_id):
    global seqNumber
    print (url)

    r = requests.get(url)
    soup = BeautifulSoup(r.content, 'lxml')
    articles_soup = soup.find_all(attrs={'class':"col-md-12 article"})

    for article_soup in articles_soup:
        PageURL = article_soup.find('a').get('href')
        try:
            RecordSnippet = article_soup.prettify().encode('utf-8').replace("\n", '').replace("'", "\\'")
        except:
            RecordSnippet = ''
        try:
            PageSnippet = get_detail(PageURL).encode('utf-8').replace("\n", '').replace("'", "\\'")
        except Exception as e:
            print ('ERROR:', e)
            PageSnippet = ''

        ScanDate = now_string()
        PublDate_string = soup.find('strong', text="Date:").parent.text.replace("Date:", '').strip()
        PublDate = datetime.strptime(PublDate_string, '%d %b %Y %H:%M:%S').strftime('%Y-%m-%d %H:%M:%S')
        categoryValue = PageURL.split("/")[1]
        CategoryId = mysql.get_fnKey('Categories', 'CategoryValue', categoryValue)
        # langVal =

        data = {'PageURL': PageURL,
                'RecordSnippet': RecordSnippet,
                'PageSnippet': PageSnippet,
                'ScanDate': ScanDate,
                'PublDate': PublDate,
                'CategoryID': CategoryId,
                # 'LanguageID': 1
                }
        # with codecs.open('record.html', 'w') as f:
        #     f.write(RecordSnippet)
        #
        # with codecs.open('page.html', 'w') as f:
        #     f.write(PageSnippet)

        cs_id = mysql.add_row('ContentSnippets', data)
        print ("QP ID: %s, CS ID: %s" %(qp_id, cs_id))
        if cs_id:
            mysql.add_row('OutputListPages', {"QP_ID": qp_id, "CS_ID": cs_id, "seqNum": seqNumber})
            seqNumber += 1

    next = soup.find('a', attrs={"class":"next"})
    if next:
        next_link = host + next.get('href')
        crawl(next_link, qp_id)

if __name__ == "__main__":
    if (len(sys.argv)) > 1:
        query_url = sys.argv[1]
        print ('Query: %s' % query_url)
    else:
        print ("Invalid Command\n"
               "Format: python avxhm_crawler.py [query_url]\n"
               "ex: python avxhm_crawler.py https://avxhm.se")
        sys.exit(1)

    host = "https://avxhm.se"
    # query_url = "https://avxhm.se"

    qp_id = mysql.add_row('QueryPages', {"PageURL": query_url, "ScanDate": now_string()})
    # try:
    #     seqNumber = mysql.get_last("OutputListPages", "QP_ID", qp_id, "seqNum")[2]
    # except:
    seqNumber = 1
    crawl(query_url, qp_id)
