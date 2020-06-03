FROM cassandra:2.1  
MAINTAINER CI&T-TEAM  
  
COPY ./migrator.sh /usr/bin/docker-entrypoint.sh  
COPY ./cqlshrc /root/.cassandra/cqlshrc  
  
ONBUILD ADD drop_keyspace.cql /opt/drop_keyspace.cql  
ONBUILD ADD create_keyspace.cql /opt/create_keyspace.cql  
ONBUILD COPY migrations/* /opt/migrations/  
  
ENV KEYSPACE_NAME default_keyspace_name  
  
CMD ["docker-entrypoint.sh"]  
  

