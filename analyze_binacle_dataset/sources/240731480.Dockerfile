FROM fabric8/java-jboss-openjdk8-jdk:1.2.1

ENV JAVA_APP_JAR 08-vertx-composite-1.0.jar
ENV AB_ENABLED off
ENV AB_JOLOKIA_AUTH_OPENSHIFT true
ENV JAVA_OPTIONS -Xmx256m
ENV ZIPKIN_SERVER_URL http://zipkin-query:9411

EXPOSE 8080

RUN chmod -R 777 /deployments/
ADD target/$JAVA_APP_JAR /deployments/
