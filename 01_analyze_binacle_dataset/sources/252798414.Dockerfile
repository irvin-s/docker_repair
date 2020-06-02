FROM python:3-alpine  
MAINTAINER Dênis Volpato Martins <denisvm@gmail.com>  
  
RUN apk add \--no-cache \  
make git \  
&& pip --no-cache-dir install sphinx  

