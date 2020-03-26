FROM ubuntu:14.04  
  
MAINTAINER Abel Muiño <amuino@gmail.com>  
  
ENV LAST_BUILD 2016-06-11  
RUN apt-get update && apt-get -y install poppler-utils && apt-get clean  

