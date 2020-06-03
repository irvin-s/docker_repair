FROM python:2-alpine3.7  
MAINTAINER Achilleas Pipinellis  
  
# Install pelican and its dependencies  
RUN apk add --no-cache --virtual .fetch-deps git perl  
RUN pip install pelican markdown typogrify bs4  
RUN rm -rf /var/cache/apk/* /var/lib/apk/* /etc/apk/cache/*  

