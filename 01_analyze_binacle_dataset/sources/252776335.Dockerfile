FROM mysql:5.7  
RUN set -ex && apt-get update && apt-get install -y \  
vim \  
pv \  
expect \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
COPY manage-db.sh /usr/local/bin/manage-db.sh  

