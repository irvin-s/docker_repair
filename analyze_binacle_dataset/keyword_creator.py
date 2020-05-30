#Before using this scpript run requirements.txt
#This script uses TF-IDF algorithm to extract keyword from Dockerfiles build crashes log.
import nltk
import re
import heapq
from nltk.corpus import stopwords

#Creating a list of stop words and adding custom stopwords
stop_words = set(stopwords.words("english"))

##Creating a list of custom stopwords and adding to stop words
new_words = ["step", "bin", "sh", "returned", "non", "zero", "code", "manifest", "unknown", "pull", "access", "denied","invalid", "reference", "format", "failed", "process", "command", "me", "mthe", "for", "from", "0mthe", "91me"]
stop_words = stop_words.union(new_words)

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