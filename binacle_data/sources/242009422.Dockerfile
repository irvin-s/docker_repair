FROM openjdk:8-alpine
VOLUME /tmp
MAINTAINER "Artsiom Kraskouski" <artem.kraskovski@gmail.com>
ADD build/libs/server.jar /pms.jar
RUN sh -c 'touch /pms.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/pms.jar"]