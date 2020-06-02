FROM wire/bots.runtime:latest

COPY target/anna.jar      /opt/anna/anna.jar
COPY certs/keystore.jks   /opt/anna/keystore.jks

WORKDIR /opt/anna
