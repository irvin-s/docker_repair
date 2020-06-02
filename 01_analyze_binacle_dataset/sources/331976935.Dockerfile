FROM maven:3-jdk-8-alpine

RUN mkdir /source
WORKDIR /source
COPY ./pom.xml .
COPY ./src/ ./src/
RUN mvn package

FROM openjdk:8-jdk-alpine
COPY --from=0 /source/target/hello-wildfly-thorntail.jar /hello-wildfly-thorntail.jar
CMD ["java", "-jar", "/hello-wildfly-thorntail.jar"]

