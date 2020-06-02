FROM java:7
MAINTAINER Mr.chang
ADD springShiro-0.0.1-SNAPSHOT.jar  ssr.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/ssr.jar"]