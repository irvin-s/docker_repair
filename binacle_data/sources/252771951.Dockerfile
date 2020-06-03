FROM postgres:9.5  
MAINTAINER AttractGroup  
  
ENV PGIS_MAJOR 2.2  
RUN apt-get update  
RUN apt-get install -y postgresql-$PG_MAJOR-postgis-$PGIS_MAJOR  

