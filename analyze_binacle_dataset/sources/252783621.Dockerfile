# start with a base image  
FROM ubuntu:latest  
  
# install dependencies  
RUN apt-get -y update && \  
apt-get install -y python python-dev python-pip python-psycopg2 && \  
apt-get install -y nginx supervisor  
  
# add requirements.txt and install  
COPY requirements.txt /code/requirements.txt  
RUN pip install -r /code/requirements.txt  
  
COPY app.py /code/app.py  
  
# set working diretory  
WORKDIR /code  

