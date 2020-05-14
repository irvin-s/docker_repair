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

#Define the url white list
url_white_lst = ['stackoverflow.com','github.com','issues','reddit.com', 'askubuntu.com', 'ubuntuforums.org', 'gitlab.com', 'medium.com', 'devops.stackexchange.com']

#Initializing variables
url = []
lines = []
dataJ = {}
i = 0

#File to store query_log
query_log = open("analyzed_query.json", "a")

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

if __name__ == "__main__":

    #filename="logs/fail/484144517.log"
    if (len(sys.argv)<2):
        print("Please, provide a file on input.\nExample format: python query_process.py logs/fail/484144517.log")
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
    while not url:
        used_keyword = keyword[i]
        for g in search(keyword[i], tld="com", lang="en", num=5, start=0, stop=6, pause=2):
            url.append(g)
            i += 1
    #for g in search(query_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
    #    url.append(g)

    #Testing query seach on google and show the results
    if not url:
        url.append("")
    print("Process finished, for log check analyzed_query.json")

#Write query_log
dataJ['Hash: '+n_hash[10:-4]] = []
dataJ['Hash: '+n_hash[10:-4]].append({
    'Log fragment': query_s,
    'Initial query': used_keyword,
    'Initial URL': ( listToDict(url) ),
    'Revised query': '',
    'Revised URL': ''
}) 
json.dump(dataJ, query_log, indent=4)
query_log.write("\n")
query_log.write("\n")
query_log.close