FROM java:8
EXPOSE 8080
ADD /target/spring-boot-demo-0.0.1.jar spring-boot-demo-0.0.1.jar
ENTRYPOINT ["java", "-jar", "spring-boot-demo-0.0.1.jar"]
