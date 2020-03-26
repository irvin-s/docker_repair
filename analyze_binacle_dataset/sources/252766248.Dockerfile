FROM openjdk:8-jre  
MAINTAINER Ordina - Maatwerk Beheer  
  
RUN apt-get update && \  
apt-get install -y postgresql-client-9.6 && \  
rm -rf /var/lib/apt/lists/*  
  
COPY wait-for-postgres.sh /wait-for-postgres.sh  
RUN ["chmod", "+x", "/wait-for-postgres.sh"]  
  

