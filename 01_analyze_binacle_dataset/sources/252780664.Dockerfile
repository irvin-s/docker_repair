# Super Simple Docker File  
from ubuntu:latest  
MAINTAINER Don Johnson "dj@codetestcode.io"  
RUN apt-get update  
RUN apt-get install -y python python-pip wget git  
RUN pip install Flask  

