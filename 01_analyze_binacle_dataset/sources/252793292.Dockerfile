FROM postgres:latest  
  
MAINTAINER Champs-Libres <info@champs-libres.coop>  
  
COPY pre-init/ /docker-entrypoint-initdb.d/  
  

