FROM python:3-alpine  
MAINTAINER Benedikt Forchhammer <b.forchhammer@gmail.com>  
  
ARG COV_VER=3.7  
RUN pip install coverage==$COV_VER  
  
VOLUME /code  
WORKDIR /code  
  
ENTRYPOINT ["coverage"]  

