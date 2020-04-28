#Before execute the script, use pip to install google lib
#Import googlesearch for URL requests 
from googlesearch import search
import sys

#Initializing variables
url = []
lines = []

#File to store query_log
query_log = open("analyzed_query.log", "a")

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
    for g in search(query_s, tld="com", lang="en", num=5, start=0, stop=6, pause=2):
        url.append(g)

    #Testing query seach on google and show the results
    if not url:
        url.append("No results found!!")
    print("Process finished, for log check analyzed_query.log")

#Write query_log
n_hash = ("Hash: ", n_hash[10:-4], "\n")
query_s = ("Query: ", query_s, "\n")
url = ("URL: ", url, "\n")
query_log.writelines(n_hash)
query_log.writelines(query_s)
query_log.writelines("%s" % url_list for url_list in url)
query_log.write("\n")
query_log.close