# base CoMSES postgis Dockerfile  
FROM postgres:9.5  
LABEL maintainer="Allen Lee <allen.lee@asu.edu>, CoMSES Net www.comses.net"  
  
ENV COMSES_UID=2718 \  
COMSES_USER=comses \  
DEBIAN_FRONTEND=noninteractive \  
LANG=C.UTF-8 \  
LC_ALL=C.UTF-8 \  
POSTGIS_MAJOR=2.3  
RUN useradd -m --uid $COMSES_UID $COMSES_USER \  
&& apt-get update \  
&& apt-get install -y \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \  
&& mkdir -p /docker-entrypoint-initdb.d \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY scripts/init-postgis.sh /docker-entrypoint-initdb.d/  

