# This is the default Dockerfile used by Docker Hub
# to build the latest version of the Fiware Cepheus-Broker project.
FROM java:8-jre
MAINTAINER FIWARE Cepheus Team

ENV CEPHEUS_VERSION 1.0.1-SNAPSHOT
ENV CEPHEUS_REPO snapshots

WORKDIR /opt/cepheus

# Download Broker
RUN wget -q -O cepheus-broker.jar "https://oss.sonatype.org/service/local/artifact/maven/redirect?r=$CEPHEUS_REPO&g=com.orange.cepheus&a=cepheus-broker&v=$CEPHEUS_VERSION"

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "cepheus-broker.jar"]
CMD []

