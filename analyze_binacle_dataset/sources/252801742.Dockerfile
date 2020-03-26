FROM alpine:3.4  
RUN apk add --update python py-pip jq  
  
RUN pip install --upgrade pip && pip install --upgrade awscli  
  
ADD assets/ /opt/resource/

