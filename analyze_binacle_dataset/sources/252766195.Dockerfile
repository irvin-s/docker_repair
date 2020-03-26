FROM alpine  
  
RUN apk add \--update --no-cache py-pip && \  
pip install --upgrade pip && \  
pip install awscli  

