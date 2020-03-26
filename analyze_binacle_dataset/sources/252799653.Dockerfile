FROM python:2.7  
# FileAuthor /Maintaner  
MAINTAINER Davide Neri  
  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /code  
WORKDIR /code  
ADD requirements.txt /code/  
RUN pip install -r requirements.txt  
ADD . /code/  

