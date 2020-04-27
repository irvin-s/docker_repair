#Before execute the script, use pip to install google lib
#Import googlesearch for URL requests 
from googlesearch import search

#Function to read log file last lines
lines = []
def lastNlines(f,n):
    with f as file:
        for line in (file.readlines()[-n:]):
            lines.append(line)
    return lines

#Function to convert list to string
def listToString(s):
    str1 = " "
    return (str1.join(map(str, s)))

#Read log file
log_file = open("logs/fail/484144517.log","r")
query = lastNlines(log_file,5)
#for p in query:
#    print(p)

#Googling error log and show de results, convert lines from list to string before use the query
query_s = listToString(query)
try:
   for g in search(query_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
        print(g)
except:
        print("Error")
