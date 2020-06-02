FROM java:8
ADD target/docker-spring-data-rest-0.0.1-SNAPSHOT.jar /docker-spring-data-rest-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/docker-spring-data-rest-0.0.1-SNAPSHOT.jar"]
