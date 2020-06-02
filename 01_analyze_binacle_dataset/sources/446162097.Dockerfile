# Python plus nltk
# Datasets loaded are: treebank, words, maxent_ne_chunker, maxent_treebank_pos_tagger, wordnet
#
# BUILDAS sudo docker build -t nlothian/python-nltk .
#
# VERSION 0.1
#


# Ubuntu 12.04
FROM nlothian/python-numpy
MAINTAINER Nick Lothian nick.lothian@gmail.com


# NLTK 
RUN pip install -U  nltk

# Datasets
RUN /usr/bin/python -m nltk.downloader maxent_treebank_pos_tagger
RUN /usr/bin/python -m nltk.downloader wordnet
RUN /usr/bin/python -m nltk.downloader treebank
RUN /usr/bin/python -m nltk.downloader words
RUN /usr/bin/python -m nltk.downloader maxent_ne_chunker



  
