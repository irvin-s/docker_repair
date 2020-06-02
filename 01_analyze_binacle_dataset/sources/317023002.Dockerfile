FROM openjdk:11-jre-slim

ADD spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar app.jar

ARG JVM_OPTS
ENV JVM_OPTS=${JVM_OPTS}

CMD java ${JVM_OPTS} -jar app.jar
