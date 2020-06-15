#Before execute the script, see requirements.txt
#This script reads a log file from a dockerfile build, and then use logs from failure build
#Get the error from the log and search on google to find URL's that contain the bug fix  
#Script usage: python query_process.py log_to_analyze

#Import googlesearch for URL requests 
from googlesearch import search
import sys
import json
import re
import os
import time
sys.path.append('../keyword_gen')
import keyword_creator 

#File to read url white list
url_white_lst = open("query_url_white_list.txt","r")
url_white_lst = url_white_lst.read().splitlines()

#File to store query_log
query_log = open("../results/analyzed_query.json", "a")

#File to read log files
log_files = open("../results/files_to_analyze.log","r")
log_files = log_files.read().splitlines()

#Function to read log file last lines
def lastNlines(f,n):
    lines = []
    with f as file:
        for line in (file.readlines()[-n:]):
            lines.append(line)
    return lines

#Function to convert list to string
def listToString(s):
    str1 = " "
    return (str1.join(s))

#Function to convert list to dict
def listToDict(lst):
    lst = { i : lst[i] for i in range(0, len(lst) ) }
    return lst

#Function to convert dict to list
def dictToList(keyword_dict):
    keyword_list = []
    for i in keyword_dict:
        keyword_list.append(listToString(keyword_dict[i]))
    return keyword_list

#Function to white listing URLs
def checkURL(wUrl):
    for white_lst in url_white_lst:
        if re.search(white_lst, wUrl):
            result = True
            break
        else:
            result = False
    return result

#Function to write a query_log.json
def writetolog(hash, fragment, keyword_log, url):
    dataJ = {} 
    dataJ['Hash: '+n_hash[13:-4]] = []
    dataJ['Hash: '+n_hash[13:-4]].append({
    'Log fragment': fragment,
    'Query': keyword_log,
    'URLs': ( listToDict(url) )
    }) 
    json.dump(dataJ, query_log, indent=4)
    query_log.write("\n")
    query_log.write("\n")
    query_log.close

#Function to query search on google
def geturl(keyword_url):
    url = []
    i = 0
    while not url:
        keyword_s = listToString(keyword_url[:6 + i])
        for g in search(keyword_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
            if checkURL(g):
                url.append(g)
        i += 2

    #If query doesn't match the searching criteria
    if not url:
        url.append("")

    res_url = keyword_s, url
    return res_url

if __name__ == "__main__":

    # No Dockerfiles to analyze -> Skip
    if not log_files:
        print("No Dockerfiles log to analyze, please check ../results/files_to_analyze.log")
        sys.exit(0)
        
    #Process the Dockerfiles to log
    for logprocess in log_files:
      filename = logprocess        
      print("Processing file {}".format(filename))

      #Read log file
      n_hash = (filename)
      log_file = open(filename,"r")
      query = lastNlines(log_file,3)
    
      #Convert lines from list to string before use the query
      query_s = listToString(query)
      query_s = query_s.replace("\n"," ")

      #Gerenating keyword
      keyword = keyword_creator.keyGen(query_s)
      keyword = dictToList(keyword)

      #Testing query search on google
      url = geturl(keyword)
      
      #Write results to log
      writetolog(n_hash, query_s, url[0], url[1])

      #Waits 3 seconds between each search to avoid HTTP error 429
      time.sleep(3.0)

print ("Process finished, for log check ../results/analyzed_query.json")