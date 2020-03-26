# This is the default Dockerfile used by Docker Hub
# to build the latest version of the Fiware-Cepheus project.
FROM java:8-jre
MAINTAINER FIWARE Cepheus Team

ENV CEPHEUS_VERSION 1.0.1-SNAPSHOT
ENV CEPHEUS_REPO snapshots

# Install Supervisor
RUN apt-get update && apt-get install -y supervisor wget
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /opt/cepheus

# Download CEP and Light Broker
RUN wget -q -O cepheus-cep.jar "https://oss.sonatype.org/service/local/artifact/maven/redirect?r=$CEPHEUS_REPO&g=com.orange.cepheus&a=cepheus-cep&v=$CEPHEUS_VERSION"
RUN wget -q -O cepheus-broker.jar "https://oss.sonatype.org/service/local/artifact/maven/redirect?r=$CEPHEUS_REPO&g=com.orange.cepheus&a=cepheus-broker&v=$CEPHEUS_VERSION"

# Expose 8080 for CEP, 8081 for broker
EXPOSE 8080 8081

# Launch supervisor
ENTRYPOINT ["/usr/bin/supervisord"]
CMD []

