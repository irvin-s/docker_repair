# FROM fabric8/java-jboss-openjdk8-jdk:1.2.7
# ENV JAVA_APP_JAR vertx-demo-0.0.1-fat.jar
# EXPOSE 8080
# RUN chmod -R 777 /deployments/
# ADD target/$JAVA_APP_JAR /deployments/

## before Fabric8
FROM openjdk:8
ENV JAVA_APP_JAR vertx-demo-0.0.1-fat.jar
WORKDIR /app/
COPY target/$JAVA_APP_JAR .
EXPOSE 8080
CMD java -XX:+PrintFlagsFinal -XX:+PrintGCDetails $JAVA_OPTIONS -jar $JAVA_APP_JAR
