#Before execute the script, see requirements.txt

#Get the error from the log and search on google to find URL's that contain the bug fix  
#Script usage: python query_process.py log_to_analyze

#Import googlesearch for URL requests 
from googlesearch import search
import sys
import json
import re

#Initializing variables
url = []
dataJ = {}


#File to read url white list
url_white_lst = open("query_url_white_list.txt","r")
url_white_lst = url_white_lst.read().splitlines()

#File to store query_log
query_log = open("../results/analyzed_query.json", "a")

#Function to conver list to dict
def listToDict(lst):
    lst = { i : lst[i] for i in range(0, len(lst) ) }
    return lst

#Function to white listing URLs
def checkURL(wUrl):
    for white_lst in url_white_lst:
        if re.search(white_lst, wUrl):
            result = True
            break
        else:
            result = False
    return result

#Function to convert list to string
def listToString(s):
    str1 = " "
    return (str1.join(s))

def getAllKeyWords():
    file = open('../results/keywords.txt','r')
    lines = []
    with file as f :
        line = f.readline().split(', ')
        lines.append(line)
    return lines

def process(n_hash, keyword):
    i = 0
    #Testing query seach on google
    while not url:
        keyword_s = listToString(keyword[:6 + i])
        for g in search(keyword_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
            if checkURL(g):
                url.append(g)
        i += 2
    #for g in search(query_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
    #    url.append(g)

    #If the url doesn't match the searching criteria
    if not url:
        url.append("")
    print("Process finished, for log check ../results/analyzed_query.json")

    #Write query_log
    dataJ['Hash: '+n_hash[13:-4]] = []
    dataJ['Hash: '+n_hash[13:-4]].append({
        #FIXME @Irvin #'Log fragment': query_s, 
        'Query': keyword_s,
        'URLs': ( listToDict(url) )
    }) 
    json.dump(dataJ, query_log, indent=4)
    query_log.write("\n")
    query_log.write("\n")
    query_log.close


if __name__ == "__main__":
    lines = getAllKeyWords()
    print (*lines, sep="\n")
    c = 0
    for line in lines:
        print (line[c])
        process(line[0], line[1:])
        c+1