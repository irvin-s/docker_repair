FROM alpine:3.6  
  
ENV SLEEP=5  
  
RUN apk add \--no-cache docker py-pip \  
&& pip install docker-compose \  
&& docker --version \  
&& docker-compose --version  
  
ADD scripts /usr/local/bin

