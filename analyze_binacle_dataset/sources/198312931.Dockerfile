FROM openjdk:8-jre-alpine
COPY target/pazuzu-registry.jar /pazuzu-registry.jar
EXPOSE 8080 8081
CMD java $JAVA_OPTS $(appdynamics-agent) $(java-dynamic-memory-opts) -jar /pazuzu-registry.jar
