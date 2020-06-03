# Version. Can change in build progress
ARG GCLOUD_SDK_VERSION=198.0.0-alpine

# Use google cloud sdk
FROM google/cloud-sdk:$GCLOUD_SDK_VERSION
MAINTAINER Singularities

# Install Java 8 for Datastore emulator
RUN apk add --update --no-cache openjdk8-jre &&\
    gcloud components install cloud-datastore-emulator beta --quiet

# Volume to persist Datastore data
VOLUME /opt/data

COPY start-datastore .

EXPOSE 8081

ENTRYPOINT ["./start-datastore"]
