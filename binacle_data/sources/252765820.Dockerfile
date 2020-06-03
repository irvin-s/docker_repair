FROM java:openjdk-7-jre  
  
# based on https://github.com/blinkreaction/docker-drupal-solr  
# Solr version  
ENV SOLR_VERSION 3.6.2  
ENV SOLR_MIRROR http://archive.apache.org/dist/lucene/solr  
ENV SOLR apache-solr-$SOLR_VERSION  
ENV SOLR_COLLECTION_PATH /opt/$SOLR/example/solr  
  
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
COPY ./conf /var/lib/solr/conf  
# Persistent volume for solr data  
VOLUME ["/var/lib/solr/data"]  
  
EXPOSE 8983  
  
WORKDIR /opt/solr/example  
  
CMD ["java", "-jar", "start.jar"]

