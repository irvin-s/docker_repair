FROM fabric8/java-jboss-openjdk8-jdk:1.5.1

ENV JAVA_APP_JAR mutual-tls-demo-1.0.0-SNAPSHOT.jar
ENV AB_ENABLED off
ENV AB_JOLOKIA_AUTH_OPENSHIFT true
ENV JAVA_OPTIONS "-Xmx128m -Djavax.net.debug=ssl:handshake:verbose -Djava.security.egd=file:///dev/./urandom"
ENV JAVA_DEBUG on

EXPOSE 8080

ADD target/mutual-tls-demo-1.0.0-SNAPSHOT.jar /deployments/