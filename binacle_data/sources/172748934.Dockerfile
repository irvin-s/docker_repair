FROM tomcat:7.0

MAINTAINER Eliot Jordan <eliot.jordan@gmail.com>

RUN apt-get update && apt-get -y install unzip
RUN wget http://sourceforge.net/projects/geoserver/files/GeoServer/2.7.2/geoserver-2.7.2-war.zip -O /tmp/geoserver.zip && \
	unzip -q /tmp/geoserver.zip -d /tmp && \
	mkdir /usr/local/tomcat/webapps/geoserver && \
	unzip /tmp/geoserver.war -d /usr/local/tomcat/webapps/geoserver && \
	rm -rf /tmp/*

CMD [ "catalina.sh", "run" ]	