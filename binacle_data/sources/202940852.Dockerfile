FROM arm64v8/openjdk:11-jdk-slim

ENV ENV docker

WORKDIR /opt/FredBoat

COPY fredboat.yml /opt/FredBoat/fredboat.yml
COPY common.yml /opt/FredBoat/common.yml
COPY FredBoat.jar /opt/FredBoat/FredBoat.jar

EXPOSE 1356

ENTRYPOINT ["java", "-Xmx128m", "-jar", "FredBoat.jar"]
