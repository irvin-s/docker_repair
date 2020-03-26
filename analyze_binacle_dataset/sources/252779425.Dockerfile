# caesar0301/catalog_builder  
FROM ubuntu:16.04  
  
MAINTAINER Xiaming Chen <chenxm35@gmail.com>  
  
## PREREQUESITES  
RUN apt-get update  
RUN apt-get install -y libmysqlclient-dev python-pip git mysql-client  

