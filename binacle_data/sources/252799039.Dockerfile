FROM alpine:3.4  
MAINTAINER Christopher De Vries <devries@idolstarastronomer.com>  
  
RUN apk add --update \  
python \  
python-dev \  
py-pip \  
build-base \  
&& rm -rf /var/cache/apk/*  
  
RUN pip install bottle  
RUN pip install gunicorn  
  
RUN addgroup -S apprunner  
RUN adduser -G apprunner -S apprunner  

