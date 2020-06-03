FROM devinci/drupal-solr:base  
  
MAINTAINER Leonid Makarov <leonid.makarov@blinkreaction.com>  
  
# SOLR 4.x version and mirror  
ENV SOLR_VERSION 4.10.4  
ENV SOLR_MIRROR http://www.mirrorservice.org/sites/ftp.apache.org/lucene/solr  
ENV SOLR solr-$SOLR_VERSION  
  
ENV SOLR_COLLECTION_PATH /opt/solr/$SOLR/example/solr/collection1  
  
# Download and install solr  
RUN /opt/install.sh  
  
CMD /opt/startup.sh;  

