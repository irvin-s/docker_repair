FROM java
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive

RUN apt-get -y --fix-missing update
RUN apt-get -y install wget

RUN cd /opt &&\
    wget http://archive.apache.org/dist/lucene/solr/4.8.1/solr-4.8.1.tgz &&\
    tar -xvf solr-4.8.1.tgz &&\
    cp -R solr-4.8.1/example /opt/solr

RUN useradd -d /opt/solr -s /sbin/false solr &&\
    chown solr:solr -R /opt/solr

RUN cd /opt/solr/solr &&\
    mv collection1 ckan &&\
    cd ckan

ADD conf/solr/schema.xml /opt/solr/solr/ckan/conf/schema.xml

VOLUME ["/opt/solr/solr/ckan/data"]

EXPOSE 8983

WORKDIR /opt/solr
CMD ["/usr/bin/java", "-jar", "/opt/solr/start.jar"]