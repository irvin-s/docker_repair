FROM postgres:10  
LABEL maintainer = "Dylan J. Richardson" <dylanjackrichardson@gmail.com>  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
postgresql-10-postgis-2.4 \  
postgresql-10-postgis-2.4-scripts \  
postgis-2.4\  
postgresql-10-pgrouting\  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /docker-entrypoint-initdb.d  
COPY ./postgis.sh /docker-entrypoint-initdb.d/postgis.sh  
COPY ./data /usr/local/bin/data  
RUN gunzip /usr/local/bin/data/*.gz

