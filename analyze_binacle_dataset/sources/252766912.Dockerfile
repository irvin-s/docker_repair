FROM makuk66/docker-solr:4.10.4  
MAINTAINER Alban Seurat "alban.seurat@me.com"  
USER root  
  
run apt-get -y update  
run apt-get -y install python-pip supervisor  
run pip install mongo-connector  
  
add ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
add ./solr.conf /etc/supervisor/conf.d/solr.conf  
add ./start-solr-node.sh /opt/solr/bin/start-solr-node.sh  
add ./mongo-connector.sh /opt/solr/bin/mongo-connector.sh  
  
run chmod a+x /opt/solr/bin/start-solr-node.sh  
run chmod a+x /opt/solr/bin/mongo-connector.sh  
  
CMD "/usr/bin/supervisord"  
  

