FROM solr:6.4  
  
ENV SOLR_HOME=/solr_home  
  
ADD willow/solr/config/ $SOLR_HOME/willow_config  
ADD geoblacklight/solr/config $SOLR_HOME/geoblacklight_config  
COPY solr/docker-entrypoint.sh /  
  
USER root  
RUN chown -R solr:solr $SOLR_HOME  
  
USER solr  
RUN cp /opt/solr/server/solr/solr.xml $SOLR_HOME  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  

