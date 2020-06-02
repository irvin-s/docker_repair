FROM postgres:9.1  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y ssl-cert && \  
rm -rf /var/lib/apt/lists/*  
  
COPY enable-ssl.sh /docker-entrypoint-initdb.d/enable-ssl.sh  

