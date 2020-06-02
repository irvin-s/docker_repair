# See https://hub.docker.com/r/library/maven/
FROM maven:3-jdk-8
MAINTAINER Geoffrey Booth <geoffrey.booth@disney.com>

COPY src /opt/src/

WORKDIR /opt/src/

RUN mvn install

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
