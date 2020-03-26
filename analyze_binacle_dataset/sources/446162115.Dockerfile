# Ubuntu 12.04 (precise) + Java
#
# BUILDAS sudo docker build -t solr .
# RUNAS sudo docker run -p 8983:8983 -v /var/data:/var/data -name wikipedia_solr solr
#
FROM nlothian/mvn3
MAINTAINER Nick Lothian nick.lothian@gmail.com


RUN mkdir -p /opt/solr

ADD solr.tgz /opt/solr.tgz

RUN tar -C /opt/solr/ --extract --file /opt/solr.tgz --strip-components 1

# This will overwrite the existing config file
ADD solr.xml /opt/solr/example/solr/solr.xml

EXPOSE 8983

CMD ["/bin/bash", "-c", "cd /opt/solr/example; java -jar start.jar"]
