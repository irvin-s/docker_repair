FROM java:8
MAINTAINER : fulln <i@fulln.me>
VOLUME  /tmp
#ARG JAR_FILE
#COPY ${JAR_FILE}  api-1.0.0.jar
COPY api-1.0.0.jar  api-1.0.0.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/api-1.0.0.jar","--spring.profiles.active=prod","> target/console.log 2>&1"]
