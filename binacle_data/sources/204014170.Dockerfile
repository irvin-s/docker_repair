FROM java:8
ADD *.jar /e-example-ms-gateway.jar
ADD application.yml /econf/ 
ENTRYPOINT ["java","-Xdebug","-Xrunjdwp:server=y,transport=dt_socket,address=8000,suspend=n","-Djava.security.egd=file:/dev/./urandom","-jar","-Dspring.config.location=/econf/application.yml","/e-example-ms-gateway.jar"]