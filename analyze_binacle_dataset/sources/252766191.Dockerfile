FROM alpine:latest  
  
RUN apk add \--update \  
python \  
py-pip && \  
adduser -D aws  
  
WORKDIR /home/aws  
  
RUN mkdir aws && \  
# pip install --upgrade pip && \  
pip install awscli  
  
USER aws

