FROM openjdk:8-jre

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD target/external-api-dropwizard-1.0-SNAPSHOT.jar /usr/src/app/external-api-dropwizard-1.0-SNAPSHOT.jar
ADD external-api-dropwizard.yml /usr/src/app

EXPOSE 3002
CMD ["java", "-jar", "-Done-jar.silent=true", "external-api-dropwizard-1.0-SNAPSHOT.jar", "server", "external-api-dropwizard.yml"]