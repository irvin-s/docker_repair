FROM python:3-alpine  
  
MAINTAINER Simone Esposito <simone@kiwi.com>  
  
RUN mkdir /app  
WORKDIR /app  
  
COPY ./requirements.txt /app  
RUN apk --no-cache --virtual=.build-deps add build-base musl-dev &&\  
pip install -r requirements.txt &&\  
apk --purge del .build-deps  
  
COPY . /app  
  
RUN python setup.py install  
  
CMD ["assets"]  
LABEL name=assets version=dev  

