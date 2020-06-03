FROM maven:3-jdk-8-alpine

RUN mkdir /source
WORKDIR /source
COPY ./pom.xml .
COPY ./src/ ./src/
RUN mvn compile assembly:single

FROM openjdk:8-jdk-alpine
COPY --from=0 /source/target/hello-javaspark-1.0-SNAPSHOT-jar-with-dependencies.jar /hello-javaspark.jar
CMD ["java", "-jar", "/hello-javaspark.jar"]

