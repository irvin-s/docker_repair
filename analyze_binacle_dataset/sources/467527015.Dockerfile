FROM maven:3.5.4-jdk-8-alpine AS build
WORKDIR /src
COPY . .
RUN mvn clean install

FROM openjdk:8u171-jdk-alpine3.8 AS final
WORKDIR /app
COPY --from=build /src/target .
EXPOSE 8761
CMD ["java", "-jar", "OcelotSampleDiscoveryService-0.0.1-SNAPSHOT.jar"]
