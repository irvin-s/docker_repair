FROM openjdk:8-jre-alpine

MAINTAINER David Smiley <dsmiley@apache.org>

WORKDIR /opt/bop-ws

# assume "mvn -DskipTests clean verify assembly:assembly has been run" already
COPY target/libs/ libs/
COPY target/*.jar libs/
COPY target/classes/dw.yml bop-ws.yml

ENV JMX=\
    JAVA_OPTS=

EXPOSE 8080 8081

ENTRYPOINT exec java $JMX $JAVA_OPTS -cp 'libs/*' edu.harvard.gis.hhypermap.bopws.DwApplicationKt server bop-ws.yml

# TODO does't work; it seems invisible! So I appended to ENTRYPOINT for now.
#CMD ["server", "bop-ws.yml"]

#TODO HEALTHCHECK would be nice; curl http but need 'curl' in the distro