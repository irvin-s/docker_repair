FROM java:8-jre
MAINTAINER Prady <pradylibrary@gmail.com>

ADD ./target/registry.jar app.jar
ENTRYPOINT ["java","-Dspring.profiles.active=docker","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

EXPOSE 8761