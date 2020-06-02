FROM postgres:10.3  
MAINTAINER Aidan Lister  
ADD create_extension.sh docker-entrypoint-initdb.d/create_extension.sh  

