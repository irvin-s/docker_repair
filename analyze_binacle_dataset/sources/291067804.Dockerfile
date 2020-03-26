FROM maven:3.5.2-jdk-8 as builder
WORKDIR /app
COPY . /app
RUN mvn package

FROM openjdk:8u151-jre-slim
WORKDIR /app
COPY --from=builder /app/target/boot2-metrics.jar .
CMD ["java", "-jar", "/app/boot2-metrics.jar"]
