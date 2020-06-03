# This Dockerfile backs an automated dockerhub build that generates an  
# image that gets used in `bitbucket-pipelines.yml`.  
FROM node:8.6.0  
  
RUN apt-get -y update  
RUN apt-get install -y python-pip python-dev  
RUN pip install -U awscli  

