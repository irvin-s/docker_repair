FROM python:alpine  
  
RUN pip install awscli && apk --no-cache add zip  

