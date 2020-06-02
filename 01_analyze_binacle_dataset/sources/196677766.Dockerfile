FROM java:8-jre
EXPOSE 8080
ADD transactions-command-side-service.jar /transactions-command-side-service.jar
ENTRYPOINT ["java", "-jar", "/transactions-command-side-service.jar"]
