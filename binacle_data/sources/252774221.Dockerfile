FROM solr:6.3.0-alpine  
  
ADD drupal-5.2-solr-6.x /solr-conf  
  
VOLUME /opt/solr/server/solr/mycores/  
  
ENV AMAZEEIO_AUTODISCOVERY_SOLR true  
  
CMD ["solr-precreate", "drupal", "/solr-conf"]  

