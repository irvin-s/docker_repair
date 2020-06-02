############################################################  
# Dockerfile to build DEV environment.  
# Project dir is mounted  
#  
# Based on Alpine Python 3.4  
############################################################  
  
# Set the base image to Ubuntu  
FROM python:3.4-alpine  
  
MAINTAINER cgarciaarano@gmail.com  
  
ENV FLASK_APP=sentinel_gui/web.py  
  
# Update the repository sources list  
RUN apk update && apk add redis  
  
# Add requirements  
COPY requirements/ /opt/app/requirements/  
  
WORKDIR /opt/app  
  
# Install Python packages and system build dependencies  
RUN apk add g++ make libffi-dev && \  
pip install -r requirements/dev.txt && \  
apk del g++ make libffi-dev && \  
rm -rf /var/cache/apk/*  
  
# Copy code  
COPY . /opt/app  
  
CMD flask run --host=0.0.0.0 --port=8080

