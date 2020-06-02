FROM crunchydata/crunchy-postgres-gis:centos7-10.0-1.6.0  
MAINTAINER André Möller <moeller@mecom.de>  
  
ADD setup.sql /opt/cpm/bin/postgres-gis/  
ENV PG_PRIMARY_USER=primaryuser \  
PGHOST="/tmp" \  
PG_MODE=set \  
PG_PRIMARY_HOST=pgset-primary \  
PG_PRIMARY_PORT=5432 \  
PG_PRIMARY_PASSWORD=password \  
PG_USER=osm \  
PG_PASSWORD=password \  
PG_DATABASE=gis \  
PG_ROOT_PASSWORD=password

