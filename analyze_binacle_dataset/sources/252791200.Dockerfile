FROM python:3.6.2-alpine  
RUN apk add \--no-cache --virtual .build-deps g++  
RUN pip install --no-cache-dir pandas==0.20.3  

