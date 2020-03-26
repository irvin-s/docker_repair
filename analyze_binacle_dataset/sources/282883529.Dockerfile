FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD target/mono_eshop.jar mono_eshop.jar
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /mono_eshop.jar" ]
