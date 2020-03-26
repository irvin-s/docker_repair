FROM java:8-jre-alpine

EXPOSE 8080

### Add microservice artifact
COPY artifacts/spring-boot-admin-docker-*.jar /opt/spring-boot-admin-docker.jar

WORKDIR /opt
ENTRYPOINT ["java", "-jar", "spring-boot-admin-docker.jar"]