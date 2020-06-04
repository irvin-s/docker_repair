#Before using this scpript run requirements.txt
#This script reads a log file from a dockerfile build, and then use logs from failure build
#This script uses TF-IDF algorithm to extract keyword from Dockerfiles build crashes log.

import nltk
import re
import heapq
import sys
import re
from nltk.corpus import stopwords

##Creating a list of custom stopwords and adding to stop words
stop_words = ["step", "bin", "sh", "returned", "non", "zero", "code", "manifest", "unknown", "pull", "access", "denied", "invalid", "reference", "format", "failed", "process", "command", "me", "mthe", "for", "from", "0mthe", "91me"]

#Removing stop words and tokenizing the text
#Pre-processing the text, lowering all characters, removing especial chars and remove new lines to simple space
def removeNoise(s):
    
    s = nltk.word_tokenize(s)
    
    for i in range (len(s)):
        s[i] = s[i].lower()
        s[i] = re.sub(r'\W', ' ', s[i])
        s[i] = re.sub(r'\s+', ' ', s[i])
    
    s = [w for w in s if not w in stop_words] 

    return s

#Function to convert list to string
def listToString(s):
    str1 = " "
    return (str1.join(s))

#Function to read log file last lines
def lastNlines(f,n):
    lines = []
    with f as file:
        for line in (file.readlines()[-n:]):
            lines.append(line)
    return lines


#Creating an histogram and ordering the text to find most repeated words
def keyGen(mytext):
    word2count = {}

    mytext = removeNoise(mytext)
    
    for data in mytext:
        words = nltk.word_tokenize(data)
        for word in words:
            if word not in word2count.keys():
                word2count[word] = 1
            else:
                word2count[word] += 1
            
    mytext = heapq.nlargest(50,word2count, key=word2count.get)
        
    return mytext

if __name__ == "__main__":

     #filename="logs/fail/484144517.log"
    if (len(sys.argv)<2):
        print("Please, provide a file on input.\nExample format: python keyword_creator.py ../logs/fail/484144517.log")
        sys.exit(-1)
    filename=sys.argv[1]        
    print("Processing file {}".format(filename))

    #Read log file
    n_hash = (filename)
    log_file = open(filename,"r")
    query = lastNlines(log_file,3)
    #for p in query:
    #    print(p)
    
    query_s = listToString(query)
    query_s = query_s.replace("\n"," ")

    keyword = keyGen(query_s)

    print(keyword)