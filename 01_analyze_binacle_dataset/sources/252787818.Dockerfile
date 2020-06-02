FROM postgres:9.6  
RUN apt-get update && \  
apt-get install -y git postgresql-server-dev-9.6 make gcc bash tree && \  
git clone https://github.com/omniti-labs/pg_amqp.git /tmp/pg_ampq && \  
cd /tmp/pg_ampq && \  
make && make install && \  
apt-get purge --auto-remove -y git postgresql-server-dev-9.6 make gcc && \  
rm -rf /var/lib/apt/lists/* /tmp/*  
  
COPY docker-healthcheck /usr/local/bin/  
  
HEALTHCHECK CMD ["docker-healthcheck"]  

