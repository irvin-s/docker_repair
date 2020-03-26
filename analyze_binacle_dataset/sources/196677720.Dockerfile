FROM java:8-jre
EXPOSE 8080
ADD accounts-query-side-service.jar /accounts-query-side-service.jar
ENTRYPOINT ["java", "-jar", "/accounts-query-side-service.jar"]
