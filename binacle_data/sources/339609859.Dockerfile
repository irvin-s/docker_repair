#
# Dockerfile for Turbine
#

FROM java:8

MAINTAINER Oreste Luci

# Install netcat
RUN apt-get update && apt-get install -y netcat

VOLUME /tmp

WORKDIR /turbine

ADD target/turbine.jar turbine.jar

RUN bash -c 'touch /turbine.jar'

ADD run.sh run.sh
RUN chmod 744 run.sh

EXPOSE 8989
CMD ["./run.sh","turbine.jar"]