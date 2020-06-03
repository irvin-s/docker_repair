FROM daveoxley/apache-proxy-ssl  
MAINTAINER Dave Oxley <couchdb-docker@oxley.email>  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -yq install \  
couchdb apache2-utils && \  
sed -i '/port = /s/^;//g' /etc/couchdb/local.ini && \  
sed -i '/bind_address = /s/^;//g' /etc/couchdb/local.ini && \  
a2enmod authz_groupfile  
  
COPY default-proxy.conf /etc/apache2/proxy-conf/  
  
RUN mkdir /etc/service/couchdb  
COPY couchdb.sh /etc/service/couchdb/run  
  
COPY init-couchdb.sh /etc/my_init.d/  
  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

