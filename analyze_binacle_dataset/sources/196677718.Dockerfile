FROM java:8-jre
EXPOSE 8080
ADD accounts-command-side-service.jar /accounts-command-side-service.jar
ENTRYPOINT ["java", "-jar", "/accounts-command-side-service.jar"]
