FROM hub.c.163.com/bingohuang/jdk8:latest

MAINTAINER Bingo Huang <me@bingohuang.com>

COPY target/spring-boot-docker-cloudcomb-0.1.0.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
