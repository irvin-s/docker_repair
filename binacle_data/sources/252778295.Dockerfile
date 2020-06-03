FROM quay.io/aptible/ubuntu:14.04  
ENV DATA_DIRECTORY /var/db  
RUN apt-get update && apt-get install -y couchdb curl && \  
rm -rf /var/lib/apt/lists/*  
  
# Note that python-couchdb is used for its `couchdb-dump` and `couchdb-load`  
# utilities.  
RUN apt-get update && \  
apt-get install -y python2.7 python-pip python-dateutil python-couchdb && \  
rm -rf /var/lib/apt/lists/*  
RUN pip install couchdb --upgrade  
RUN mkdir -p /var/run/couchdb  
  
# This is a little bit convoluted.  
# The INI file needs to be persisted (in a volume) because it keeps track of  
# the "require auth" setting. It makes sense to set up a symlink here so that  
# couchdb will find the local.ini in the volume. If we added local.ini to the  
# volume directory here, and then bind-mounted the volume directory, the  
# data would get lost. Therefore, put the local.ini template file in /tmp  
# for now and copy it over to the volume as part of the initialization script.  
ADD templates/etc/couchdb/local.ini /tmp/couchdb/local.ini  
RUN ln -sf "$DATA_DIRECTORY"/local.ini /etc/couchdb  
  
ADD run-database.sh /usr/bin/  
  
ADD test /tmp/test  
RUN bats /tmp/test  
  
VOLUME ["$DATA_DIRECTORY"]  
EXPOSE 5984  
ADD utilities.sh /usr/bin/  
ENTRYPOINT ["run-database.sh"]  

