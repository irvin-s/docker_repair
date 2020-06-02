FROM java:8
ADD target/spring-session-demo-0.0.1-SNAPSHOT.jar /opt/spring/spring-session-demo.jar
EXPOSE 8080
WORKDIR /opt/spring/
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "spring-session-demo.jar"]