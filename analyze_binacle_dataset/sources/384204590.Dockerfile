FROM ubuntu:latest
MAINTAINER docker@noroute.de

RUN apt-get update
RUN apt-get install openjdk-7-jre-headless -y

ADD ./build/libs/spring-boot-helloworld-0.1.0.jar /service.jar

EXPOSE 8080
ENTRYPOINT java -jar /service.jar