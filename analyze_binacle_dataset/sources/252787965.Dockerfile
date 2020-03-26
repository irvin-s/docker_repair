FROM python:3  
MAINTAINER Craig Sketchley "craigsketchley@gmail.com"  
RUN pip install -U spacy  
RUN python -m spacy.en.download  

