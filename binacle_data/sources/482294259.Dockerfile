FROM openjdk:8-jre-alpine

MAINTAINER David Smiley <dsmiley@apache.org>

WORKDIR /opt/enrich

COPY target/libs/ libs/

COPY target/classes/ classes/

ENV JAVA_JMX=\
    JAVA_OPTS=

ENTRYPOINT exec java $JMX $JAVA_OPTS -cp 'classes/:libs/*' edu.harvard.gis.hhypermap.bop.enrich.Enrich