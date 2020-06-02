# etcd-secure  
#  
# VERSION 0.0.2  
FROM coreos/etcd  
MAINTAINER bfosberry  
VOLUME /opt/keys  
  
ADD ./run.sh /opt/etcd/run.sh  
  
ENTRYPOINT ["/opt/etcd/run.sh"]  

