FROM cantara/alpine-openjdk-jdk8
COPY spring-boot-docker.jar /spring-boot-docker.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/spring-boot-docker.jar"]