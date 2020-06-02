FROM java:8-jre
COPY config.yml /opt/dropwizard/
COPY build/libs/docker-dropwizard-application-standalone.jar /opt/dropwizard/
EXPOSE 8080
WORKDIR /opt/dropwizard
CMD ["java", "-jar", "-Done-jar.silent=true", "docker-dropwizard-application-standalone.jar", "server", "config.yml"]
