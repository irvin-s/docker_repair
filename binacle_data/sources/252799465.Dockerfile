FROM docker:latest  
MAINTAINER Aymeric Bringard <diadzine@ŋmail.com>  
  
RUN apk add --no-cache py-pip  
RUN pip install pip -U  
RUN pip install docker-compose  

