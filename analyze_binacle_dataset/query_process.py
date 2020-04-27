#Before execute the script, use pip to install google lib
#Import googlesearch for URL requests 
from googlesearch import search

#File to store query_log
#query_log = open("AUTO_REPAIRS.txt", "w")

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
    return (str1.join(s))

#Read log file
n_hash = ("logs/fail/484144517.log")
log_file = open("logs/fail/484144517.log","r")
query = lastNlines(log_file,1)
#for p in query:
#    print(p)

#Googling error log and show de results, convert lines from list to string before use the query
query_s = listToString(query)
query_s = query_s.replace("\n"," ")
for g in search(query_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
    url = g

#Testing query seach on google and show the results
if ('url' not in locals()):
    print("No results found using searching terms: ", query_s)
else:
    print("Hash: ", n_hash[10:-4])
    print("Query: ", query_s)
    print("URL: ", url)

#Write query_log
#query_log.write("Hash: ", n_hash[10:-4])
#query_log.write("Query: ", query_s)
#query_log.write("URL: ", url)
#query_log.close