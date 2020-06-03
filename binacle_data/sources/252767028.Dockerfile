FROM postgres:9.5.4  
  
ENV POSTGIS_MAJOR=2.3 \  
POSTGIS_VERSION=2.3.0+dfsg-2.pgdg80+1  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \  
postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \  
postgis=$POSTGIS_VERSION \  
python3-pip python3-dev \  
lzop pv \  
build-essential \  
daemontools && \  
pip3 install wal-e[aws]==1.0.0rc1 && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

