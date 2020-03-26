FROM openjdk:latest

MAINTAINER cj.zhao <cj.zhao@caixintech.com>

ENV DEBIAN_FRONTEND noninteractive

ENV TZ=Asia/Shanghai

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD *.jar app.jar

RUN sh -c 'touch /app.jar'

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
