FROM postgres:9.5-alpine  
MAINTAINER Siddhartha Basu<siddhartha-basu@northwestern.edu>  
  
# place for custom configuration files  
RUN mkdir -p /etc/postgresql/conf.d  
COPY postgresql.conf /etc/postgresql/  
COPY [^p]*.conf /etc/postgresql/conf.d/  
COPY *.sh /docker-entrypoint-initdb.d/  

