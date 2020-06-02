#Before execute the script, see requirements.txt
#This script reads a log file from a dockerfile build, and then use logs from failure build
#Get the error from the log and search on google to find URL's that contain the bug fix  
#Script usage: python query_process.py log_to_analyze

#Import googlesearch for URL requests 
from googlesearch import search
import sys
import json
import re
import keyword_creator

#Initializing variables
url = []
lines = []
dataJ = {}
i = 0

#File to read url white list
url_white_lst = open("query_url_white_list.txt","r")
url_white_lst = url_white_lst.read().splitlines()

#File to store query_log
query_log = open("../results/analyzed_query.json", "a")

#Function to read log file last lines
def lastNlines(f,n):
    with f as file:
        for line in (file.readlines()[-n:]):
            lines.append(line)
    return lines

#Function to convert list to string
def listToString(s):
    str1 = " "
    return (str1.join(s))

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

if __name__ == "__main__":

    #filename="logs/fail/484144517.log"
    if (len(sys.argv)<2):
        print("Please, provide a file on input.\nExample format: python query_process.py ../logs/fail/484144517.log")
        sys.exit(0)
    filename=sys.argv[1]        
    print("Processing file {}".format(filename))

    #Read log file
    n_hash = (filename)
    log_file = open(filename,"r")
    query = lastNlines(log_file,3)
    #for p in query:
    #    print(p)
    
    #Googling error log and show de results, convert lines from list to string before use the query
    query_s = listToString(query)
    query_s = query_s.replace("\n"," ")

    #Gerenating keyword
    keyword = keyword_creator.keyGen(query_s)
    
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
    print("Process finished, for log check results/analyzed_query.json")

#Write query_log
dataJ['Hash: '+n_hash[10:-4]] = []
dataJ['Hash: '+n_hash[10:-4]].append({
    'Log fragment': query_s,
    'Query': keyword_s,
    'URLs': ( listToDict(url) )
}) 
json.dump(dataJ, query_log, indent=4)
query_log.write("\n")
query_log.write("\n")
query_log.close