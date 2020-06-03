FROM postgres:9.6  
MAINTAINER Mike Dillon <mike@appropriate.io>  
  
ENV POSTGIS_MAJOR 2.3  
ENV POSTGIS_VERSION 2.3.1+dfsg-1.pgdg80+1  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
binutils libproj-dev gdal-bin libgeoip1 libgeos-dev \  
libgeos-3.4.2 libgeos-c1 proj-bin proj-data \  
libgdal-dev libgdal1-dev \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \  
postgis=$POSTGIS_VERSION \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /docker-entrypoint-initdb.d  
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh  

