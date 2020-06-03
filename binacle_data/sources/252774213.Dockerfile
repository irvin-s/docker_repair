FROM amazeeio/centos:7  
COPY yum.mongodb-org-3.4.repo /etc/yum.repos.d/mongodb-org-3.4.repo  
  
RUN yum install -y mongodb-org && \  
yum clean all  
  
RUN mv /etc/mongod.conf /etc/mongod.conf.orig && \  
mkdir -p /data/db /data/configdb && \  
fix-permissions /data/db && \  
fix-permissions /data/configdb  
  
COPY docker-entrypoint /docker-entrypoint  
  
CMD ["mongod"]  
  
ENTRYPOINT ["/docker-entrypoint"]  

