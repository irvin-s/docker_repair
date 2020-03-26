#vim: set ft=dockerfile  
FROM postgres:9.5  
MAINTAINER Damien Clochard <damien.clochard@dalibo.com>  
  
WORKDIR /tmp  
  
RUN apt-get update && apt-get install -y \  
postgresql-9.5-python3-multicorn  
  
COPY . /tmp/  
  
ADD docker_init.sh /docker-entrypoint-initdb.d/  
  
RUN cd /tmp && python3 setup.py install  

