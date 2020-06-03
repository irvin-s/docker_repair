FROM alpine  
MAINTAINER Chad Peterson, chapeter@cisco.com  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache git bash python py-pip tzdata gcc  
  
RUN cp /usr/share/zoneinfo/America/Chicago /etc/localtime  
RUN echo "America/Chicago" > /etc/timezone  
  
RUN apk del tzdata  
  
RUN pip install --upgrade pip  
  

