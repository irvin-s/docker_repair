FROM postgres:9.4  
MAINTAINER Michael B. Klein <michael.klein@northwestern.edu>  
ADD init-db/* /docker-entrypoint-initdb.d/  

