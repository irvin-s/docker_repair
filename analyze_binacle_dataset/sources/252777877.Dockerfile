FROM mdillon/postgis:9.6  
ENV POSTGRESQL_MAJOR 9.6  
# Install general dependencies (based on nodesource/trusty-base)  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends\  
apt-transport-https \  
ssh-client \  
build-essential \  
ca-certificates \  
git \  
libicu-dev \  
'libicu[0-9][0-9].*' \  
lsb-release \  
python-all \  
rlwrap \  
software-properties-common \  
# Install postgresql-server-dev  
postgresql-server-dev-9.6 \  
&& rm -rf /var/lib/apt/lists/*;  
  
# Do not install plpythonu via apt because it reinstalls PostgreSQL  
RUN mkdir -p /tmp && cd /tmp \  
&& apt-get update \  
&& apt-get download postgresql-plpython-9.6=9.6.3-1.pgdg80+1 \  
&& dpkg --force-all -i ./postgresql-plpython-9.6_9.6.3-1.pgdg80+1_amd64.deb  
  
# Install pg_schema_triggers extension  
RUN mkdir -p /tmp && cd /tmp \  
&& git clone https://github.com/CartoDB/pg_schema_triggers.git \  
&& cd pg_schema_triggers \  
&& make && make install  
  
# Install cartodb-postgresql extension  
RUN mkdir -p /tmp && cd /tmp \  
&& git clone https://github.com/CartoDB/cartodb-postgresql.git \  
&& cd cartodb-postgresql \  
&& make all install \  
&& rm -rf /tmp  
  
RUN mkdir -p /docker-entrypoint-initdb.d  
COPY setup-database.sh /docker-entrypoint-initdb.d/setup-database.sh  

