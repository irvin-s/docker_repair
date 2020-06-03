FROM java:openjdk-7-jre  
  
MAINTAINER Leonid Makarov <leonid.makarov@blinkreaction.com>  
  
# Solr version  
ENV SOLR_VERSION 4.10.4  
ENV SOLR_MIRROR http://archive.apache.org/dist/lucene/solr  
ENV SOLR solr-$SOLR_VERSION  
ENV SOLR_COLLECTION_PATH /opt/$SOLR/example/solr/collection1  
  
# Download and unpack solr, symlink configuration and data directories  
RUN set -x && \  
curl -sSL $SOLR_MIRROR/$SOLR_VERSION/$SOLR.tgz -o /opt/$SOLR.tgz && \  
tar -C /opt/ --extract --file /opt/$SOLR.tgz && \  
rm /opt/$SOLR.tgz && \  
ln -s /opt/$SOLR /opt/solr && \  
rm -rf $SOLR_COLLECTION_PATH/conf && \  
ln -s /var/lib/solr/conf $SOLR_COLLECTION_PATH/conf && \  
ln -s /var/lib/solr/data $SOLR_COLLECTION_PATH/data  
  
# Copy configs  
COPY ./solr/conf /var/lib/solr/conf  
  
# Persistent volume for solr data  
VOLUME ["/var/lib/solr/data"]  
  
EXPOSE 8983  
WORKDIR /opt/solr/example  
  
CMD ["/opt/solr/bin/solr", "-f"]  

