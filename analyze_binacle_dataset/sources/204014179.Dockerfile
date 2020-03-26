FROM java:8
ADD *.jar /e-example-ms-log.jar
ADD application.yml /econf/
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","-Dspring.config.location=/econf/application.yml","/e-example-ms-log.jar"]