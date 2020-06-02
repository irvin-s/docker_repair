FROM openjdk:8-jdk-alpine
COPY ./target/oauth-authorization-server.jar oauth-authorization-server.jar
ENTRYPOINT ["java","-jar","/oauth-authorization-server.jar"]
EXPOSE 8090