from nltk.corpus import stopwords 
from nltk.tokenize import word_tokenize
import re
  
example_sent = " ---> Running in b1bb1e6548cc  \u001b[91mOperation failed: No such file or directory  \u001b[0mThe command '/bin/sh -c systemctl enable libvirtd' returned a non-zero code: 1 "
  
stop_words = set(stopwords.words('english'))

new_words = [" ","step", "bin", "sh", "returned", "non zero", "code", "manifest", "unknown", "pull", "access", "denied","invalid", "reference", "format", "failed", "process", "command", "me", "mthe", "for", "from", "0mthe", "91me"]

stop_words = stop_words.union(new_words)

def clean(word_tokens):
        word_tokens = word_tokenize(word_tokens) 

        for i in range (len(word_tokens)):
                word_tokens[i] = word_tokens[i].lower()
                word_tokens[i] = re.sub(r'\W', ' ', word_tokens[i])
                word_tokens[i] = re.sub(r'\s+', ' ', word_tokens[i])

        filtered_sentence = [w for w in word_tokens if not w in stop_words]
        return filtered_sentence

print(clean(example_sent))
  
#filtered_sentence = [] 
  
"""for w in word_tokens: 
    if w not in stop_words: 
        filtered_sentence.append(s) 
  
print(word_tokens) 
print(filtered_sentence)""" 