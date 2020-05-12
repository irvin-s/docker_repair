#Before using this scpript run requirements.txt
#This script uses RAKE algorithm to extract keyword from dockerfiles build crashes log.
from rake_nltk import Rake

#Instantiate rake
r= Rake()

#Input the log fragment
mytext = '''\u001b[0m\u001b[91mnpm ERR! Please include the following file with any support request:  npm ERR!\u001b[0m\u001b[91m     /src/npm-debug.log  \u001b[0mThe command '/bin/sh -c npm run pkg-docker && npm run pkg-docker-healthcheck' returned a non-zero code: 254'''

#Extract the keywords
r.extract_keywords_from_text(mytext)

#Rank keywords from log fragment
result = r.get_ranked_phrases_with_scores()

#Show the results
print (*result, sep = '\n')