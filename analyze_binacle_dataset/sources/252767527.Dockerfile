FROM mysql  
  
MAINTAINER Alessandro Buggin <alessandrobuggin@gmail.com>  
  
USER root  
  
COPY *.sql /docker-entrypoint-initdb.d/  
  
ENV MYSQL_ROOT_PASSWORD=camel-test  
  

