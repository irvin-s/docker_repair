FROM maven:3.5-jdk-8 as BUILD

RUN mkdir /app
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package

FROM openjdk:8-jre
WORKDIR /app/
COPY --from=BUILD /app/target/ColorsService-0.0.1-SNAPSHOT.jar color.jar
EXPOSE 4567
CMD ["java","-jar","color.jar"]
