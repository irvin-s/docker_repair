FROM makuk66/docker-solr

RUN rm /opt/$SOLR/example/solr/collection1/conf/schema.xml
ADD schema.xml /opt/$SOLR/example/solr/collection1/conf/schema.xml
EXPOSE 8983

CMD ["/bin/bash", "-c", "cd /opt/solr/example; java -jar start.jar"]
