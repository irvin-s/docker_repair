FROM python:3.5  
ADD . /code  
WORKDIR /code  
RUN pip install -r requirements.txt  
CMD python hello-world.py  
  
FROM ubuntu:14.04  
RUN apt-get update -y  
RUN apt-get install -y curl  
RUN apt-get install -y vim  

