FROM openjdk:8

MAINTAINER Sivaprakash Ramasamy<sivaprakash.ramasamy@tarento.com>

#RUN apk update && apk add openssl && wget  https://github.com/pinterest/secor/archive/master.zip -O master.zip &&  unzip master.zip && cd secor-master && mvn package
# copy pre-built JAR into image
#
# INSTRUCTIONS ON HOW TO BUILD JAR:
# Move to the location where pom.xml is exist in project and build project using below command
# "mvn clean package"
RUN mkdir -p /opt/secor
ADD target/secor-*-bin.tar.gz /opt/secor/
COPY properties/* /opt/secor/
COPY src/main/scripts/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
