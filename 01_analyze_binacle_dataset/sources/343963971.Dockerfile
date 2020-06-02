FROM openjdk:8u141-jdk-slim
MAINTAINER jeremydeane.net
EXPOSE 8080
RUN mkdir /app/
COPY target/mock-saas-1.0.3.jar /app/
ENTRYPOINT exec java $JAVA_OPTS -jar /app/mock-saas-1.0.3.jar