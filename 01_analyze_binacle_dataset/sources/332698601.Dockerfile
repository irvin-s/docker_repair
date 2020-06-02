FROM gradle:5.2.1-jdk11-slim AS builder
WORKDIR /home/gradle/project
COPY build.gradle ./
COPY src ./src
USER root
RUN gradle build

FROM openjdk:11.0.2-jre-slim
COPY --from=builder /home/gradle/project/build/distributions/project.tar /app/
WORKDIR /app
RUN tar -xvf project.tar
WORKDIR /app/project
CMD java -classpath "lib/*" clients.VehiclePositionConsumer
        