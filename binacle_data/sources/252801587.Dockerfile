FROM python:3.6-slim  
  
RUN apt-get update -y  
RUN pip install python-redmine  
  
RUN mkdir redmine-wikibot  
  
WORKDIR /redmine-wikibot  
  
ADD ./listcontainers.py .

