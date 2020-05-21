#Before using this scpript run requirements.txt
#This script uses RAKE algorithm to extract keyword from dockerfiles build crashes log.
from rake_nltk import Metric, Rake
import re

#Pre_processing the text to remove noise, punctuation, tags and stopwords
def removeNoise(s):
    s = re.sub('[^A-Za-z0-9]+', ' ', s)
    return s

#Instantiate rake
r= Rake(language="",
ranking_metric=Metric.WORD_FREQUENCY,
stopwords=('step', 'bin', 'sh', 'returned', 'non', 'zero', 'code', 'manifest', 'unknown', 'pull', 'access', 'denied','invalid', 'reference', 'format', 'failed', 'process', 'command', 'me', 'mthe', 'for', 'from'), 
punctuations=("", "'\'", "") )

def keyGen(mytext):
    #Sanitize the log fragment
    mytext = removeNoise(mytext)

    #Extract the keywords
    r.extract_keywords_from_text(mytext)

    #Rank keywords from log fragment
    mytext = r.get_ranked_phrases()
    
    return mytext