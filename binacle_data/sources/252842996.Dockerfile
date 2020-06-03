FROM openjdk:8-jdk-alpine

# gating version
ENV GATLING_VERSION 2.3.0

# create directory for gatling install
RUN mkdir -p /opt/gatling
WORKDIR /opt

# install gatling
RUN apk add --update wget bash && \
  wget -q -O /tmp/gatling-$GATLING_VERSION.zip \
  https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip && \
  unzip -qq /tmp/gatling-$GATLING_VERSION.zip -d /opt/gatling && \
  rm /tmp/gatling-$GATLING_VERSION.zip

WORKDIR  /opt/gatling
COPY performance/gatling/ /opt/gatling/gatling-charts-highcharts-bundle-$GATLING_VERSION

CMD cd gatling* && \
    /bin/bash -l -c "./bin/gatling.sh -s RecordedSimulation"