# -*- coding: utf-8 -*-
import sys
import codecs
import json
import re
from datetime import datetime
from urlparse import urljoin
from multiprocessing import Pool

import requests
from bs4 import BeautifulSoup

import mysql
import config

def now_string():
    date_string = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    return date_string


def get_detail(url):
    url = host + url
    r = requests.get(url)
    soup = BeautifulSoup(r.content, 'lxml')
    article = soup.find(attrs={"class":"col-md-12 article"})

    return article.prettify()

def detect_language(text):
    NO_LANGUAGE_DETECTED = 0
    MULTILANGUAGE_DETECTED = 9
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


def crawl(args):
    page_url = args['QueryUrl']
    seq_number = args['SeqNumber']

    r = requests.get(page_url)
    soup = BeautifulSoup(r.content, 'lxml')
    articles_soup = soup.find_all(attrs={'class':"col-md-12 article"})

    for article_soup in articles_soup:
        PageURL = article_soup.find('a').get('href')
        if args.get('ExitOn8KnownPathURL') == "Y":
            if mysql.get_last("ContentSnippets", "PageURL", PageURL, "CS_ID"):
                args['KnownPathURL'] += 1
            if args['KnownPathURL'] >= 8:
                return

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
        PublDate = datetime.strptime(PublDate_string, '%d %b %Y %H:%M:%S').strftime('%Y-%m-%d')
        categoryValue = PageURL.split("/")[1]
        CategoryId = mysql.get_row_by_fnKey('Categories', 'CategoryValue', categoryValue)[0]
        LanguageId = detect_language(article_soup.text.strip())

        data = {'PageURL': PageURL,
                'RecordSnippet': RecordSnippet,
                'ScanDate': ScanDate,
                'PublDate': PublDate,
                'CategoryID': CategoryId,
                'LanguageID': LanguageId
                }

        if args.get('InclQPinCS'):
            data.update({'QP_ID': args.get('QpId')})
        if CategoryId not in ["N", "Z"]:
            data.update({'PageSnippet': PageSnippet})

        cs_id = mysql.add_row('ContentSnippets', data)
        print ("QP ID: %s, CS ID: %s" %(args.get('QpId'), cs_id))

        if cs_id and args.get('GenOLPRecord', 0):
            mysql.add_row('OutputListPages', {"QP_ID": args.get('QpId'), "CS_ID": cs_id, "seqNum": seq_number, "QueryType":args.get('QueryTypeInOLP')})
            seq_number += 1

        main_title = article_soup.find(attrs={'class':'title-link'}).text
        InterstingTerms_rows = mysql.get_allrows('InterestingTerms', 'CategoryID', CategoryId)
        for InterstingTerms_row in InterstingTerms_rows:
            intersting_term = InterstingTerms_row[1]
            if intersting_term in main_title:
                mysql.add_row('InterestingSnippets', {'CS_ID': cs_id, 'IT_ID': InterstingTerms_row[0]})

    next = soup.find('a', attrs={"class":"next"})
    if next:
        next_link = host + next.get('href')
        args['QueryUrl'] = next_link
        args['SeqNumber'] = seq_number

        crawl(args)


def main():
    config.logger.info("----- tasks ----")

    tasks_args = []
    task_list = mysql.get_allrows('TaskList', 'IsDone', 'N')
    for task in task_list:
        task_id = task[0]
        date_category = task[3]
        task_setting_id = task[4]
        if task_setting_id != "H":
            mysql.update('TaskList', {'IsDone': "'Y'"}, {'TaskID': task_id})

        task_settings = mysql.get_row_by_fnKey('TaskSettings', 'TaskSettingID', task_setting_id)

        args = {'QueryUrl': urljoin(host, date_category),
                'GenQPRecord': task_settings[2],
                'GenOLPRecord': task_settings[3],
                'InclQPinCS': task_settings[4],
                'ExitOn8KnownPathURL': task_settings[5],
                'ResetSeqNumInOLP': task_settings[6],
                'InclPublDateInQP': task_settings[7],
                'QueryTypeInOLP': task_settings[8],
                'SeqNumber': 0
                }

        if args['GenQPRecord'] == 'Y':
            data = {"PageURL": args['QueryUrl'], "ScanDate": now_string()}
            if args['InclPublDateInQP'] == "Y":
                try:
                    publ_date = re.search(r'\d+/\d+/\d+', args['QueryUrl']).group().replace("/", "-")
                    data.update({'PublDate':publ_date})
                except Exception as e:
                    config.logger.error(e)

            qp_id = mysql.add_row('QueryPages', data)
            args.update({'QpId': qp_id})

        if args['ExitOn8KnownPathURL'] == "Y":
            args.update({'KnownPathURL':0})

        config.logger.info(args)
        tasks_args.append(args)

        # crawl(args)

    print ("Count of Tasks: %d" %len(tasks_args))
    p = Pool()
    p.map(crawl, tasks_args)



if __name__ == "__main__":
    host = "https://avxhm.se"
    langs = {langID: langName for (langID, langName, _) in mysql.get_allrows('Languages')}
    main()
