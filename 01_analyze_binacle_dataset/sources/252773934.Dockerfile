#Download base image ubuntu 14.04  
FROM ubuntu:14.04  
# Update Ubuntu Software repository  
RUN apt-get update  
COPY run.py /run.py

