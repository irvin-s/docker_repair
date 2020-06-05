#Before execute the script, see requirements.txt

#Get the error from the log and search on google to find URL's that contain the bug fix  
#Script usage: python query_process.py log_to_analyze

#Import googlesearch for URL requests 
from googlesearch import search
import sys
import json
import re
import time
import os

OUTPUT_FILE = '../results/analyzed_query.json'

logs=[]
#File to read url white list
url_white_lst = open("query_url_white_list.txt","r")
url_white_lst = url_white_lst.read().splitlines()


#Function to convert list to string
def listToString(s):
    str1 = " "
    return (str1.join(s))

#Function to conver list to dict
def listToDict(lst):
    lst = { i : lst[i] for i in range(0, len(lst) ) }
    return lst

#Read the keywords
def getAllKeyWords():
    file = open ( '../results/keywords.txt' , 'r')
    lines = []
    lines = [ line.split() for line in file]
    return lines

#Function to white listing URLs
def checkURL(wUrl):
    for white_lst in url_white_lst:
        if re.search(white_lst, wUrl):
            result = True
            break
        else:
            result = False
    return result

#used to read all json file and return
def readLog():
    if os.path.exists(OUTPUT_FILE):
        read_create = 'r' # read if already exists
        print('creating outuput file')
    else:
        read_create = 'w' # make a new file if not
        print('nao')
    with open(OUTPUT_FILE, read_create) as json_file:
        try:
            data = json.load(json_file)
        except Exception as _:
            data = []
    return data

#used to add a new log, first read the previous logs then append a new log and salve all logs in file
def addLog(n_hash, url, keyword_s):
    #File to store query_log
    logs = readLog()
    dataJ = {}
    #Write query_log
    dataJ['hash'] = n_hash[13:-5]
    dataJ['query'] = keyword_s
    dataJ['URLs'] = listToDict(url)
    
    logs.append(dataJ)

    query_log = open(OUTPUT_FILE, "w")
    json.dump(logs, query_log, indent=2)

# Process the keyword
def process(n_hash, keyword):
    i = 0
    url = []

    #Testing query seach on google
    while not url:
        keyword_s = listToString(keyword[:6 + i])
        keyword_s = keyword_s.replace(',','')
        for g in search(keyword_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
            if checkURL(g):
                url.append(g)
        i += 2
    #for g in search(query_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
    #    url.append(g)
    
    #If the url doesn't match the searching criteria
    if not url:
        url.append("")
    
    addLog(n_hash, url, keyword_s)

if __name__ == "__main__":
    keywords = getAllKeyWords()
    print('Processing...')
    for line in keywords:
        process(line[0], line[1:])
        time.sleep(6.0)
    print("Process finished, for log check ../results/analyzed_query.json")