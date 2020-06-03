FROM openjdk:10-jdk-slim
MAINTAINER Rahman Usta
WORKDIR /opt/module-graph/
COPY target/module-graph.jar .
CMD ["java","-jar","./module-graph.jar"]