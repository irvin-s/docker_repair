# Dockerfile

FROM java:8

RUN echo "deb [check-valid-until=no] http://cdn-fastly.deb.debian.org/debian jessie main" > /etc/apt/sources.list.d/jessie.list
RUN echo "deb [check-valid-until=no]  http://ftp3.nrc.ca jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get -o Acquire::Check-Valid-Until=false update
RUN apt-get update && apt-get install -y ssh telnet

ARG VERSION
RUN mkdir -p /opt/swiftledger
COPY target/example.jar /opt/swiftledger/example.jar
RUN bash -c 'touch /opt/swiftledger/example.jar'

WORKDIR /opt/swiftledger

ENV JAVA_OPTS=""
ENV SPRING_PROFILES_ACTIVE="docker-solo"
ENV USED_MYSQL=false

VOLUME /app-data

EXPOSE 7070
EXPOSE 8800
EXPOSE 2000

ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /opt/swiftledger/example.jar --spring.profiles.active=$SPRING_PROFILES_ACTIVE --trust.useMySQL=$USED_MYSQL
