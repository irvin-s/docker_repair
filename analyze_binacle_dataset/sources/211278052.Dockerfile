# FROM openjdk:8
FROM marceldekoster/alpine-oracle-jdk-8
COPY build/libs/rulesengine-0.3.0-SNAPSHOT.jar /app/rulesengine.jar
EXPOSE 8080
ENV CLASSPATH /app/rulesengine.jar
ENTRYPOINT ["java", "-jar", "/app/rulesengine.jar"]
