FROM openjdk:8u121-jre-alpine
MAINTAINER Automation Rhapsody http://automationrhapsody.com/

WORKDIR /var/dropwizard-rest-stub

ADD target/sample-dropwizard-rest-stub-1.0-SNAPSHOT.jar /var/dropwizard-rest-stub/dropwizard-rest-stub.jar
ADD config-docker.yml /var/dropwizard-rest-stub/config.yml

EXPOSE 9000 9001

ENTRYPOINT ["java", "-jar", "dropwizard-rest-stub.jar", "server", "config.yml"]