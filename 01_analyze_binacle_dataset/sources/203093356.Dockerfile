FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV JAVA_APP_JAR hola-thorntail.jar
ENV AB_ENABLED off
ENV JAVA_OPTIONS -Xmx512m

EXPOSE 8080

ADD target/hola-thorntail.jar /deployments/
