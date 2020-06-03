FROM mysql:5.7  
MAINTAINER Cesar Andres Lopez "cesar.lopez@senseta.com"  
RUN apt-get update && apt-get -y install wget unzip  
WORKDIR /app  
  
COPY ./geo /geonames  
  
WORKDIR /geonames  
  
RUN ./geonames_importer.sh -a download-data  
  
COPY ./geo/a_sentiment_import.sql /docker-entrypoint-initdb.d/  
COPY ./geo/b_geonames_db_struct.sql /docker-entrypoint-initdb.d/  
COPY ./geo/c_geonames_import_data.sql /docker-entrypoint-initdb.d/  

