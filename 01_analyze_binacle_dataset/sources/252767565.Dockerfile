FROM python:3.6-alpine  
  
RUN apk add \--no-cache bash  
  
RUN pip install --upgrade pip; pip install -U awscli awsebcli  
  
RUN adduser -D -u 500 aws  
USER aws  
WORKDIR /home/aws  

