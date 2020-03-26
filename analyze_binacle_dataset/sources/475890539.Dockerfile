FROM ubuntu:trusty
MAINTAINER Patrick Oberdorf <patrick@oberdorf.net>

ENV TERM linux

RUN apt-get update && apt-get install -y \
	openjdk-7-jre-headless \
	wget \
	unzip \
	curl \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD install-solr.sh /install-solr.sh
RUN chmod +x /install-solr.sh
RUN /install-solr.sh arabic armenian basque brazilian_portuguese bulgarian burmese catalan chinese czech danish dutch english finnish french galician german greek hindi hungarian indonesian italian japanese khmer korean lao norwegian persian polish portuguese romanian russian spanish swedish thai turkish ukrainian

ADD solr.xml /opt/solr-tomcat/solr/solr.xml
RUN sed -i 's/address="127.0.0.1"/address="0.0.0.0"/' /opt/solr-tomcat/tomcat/conf/server.xml
ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 8080
CMD ["/run.sh"]
