FROM makuk66/docker-solr
MAINTAINER Micah Martin <micahlmartin@gmail.com>

COPY config /opt/solr/example/solr

EXPOSE 8983
CMD ["/bin/bash", "-c", "cd /opt/solr/example; java -jar start.jar"]

