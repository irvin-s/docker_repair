FROM openjdk:8-jre-alpine

MAINTAINER David Smiley <dsmiley@apache.org>

WORKDIR /opt/bop-ingest

COPY target/libs/ libs/
COPY target/*.jar libs/

ENV JMX=\
    JAVA_OPTS=

ENTRYPOINT exec java $JMX $JAVA_OPTS -cp 'libs/*' edu.harvard.gis.hhypermap.bop.ingest.Ingest