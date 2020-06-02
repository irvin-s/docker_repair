FROM maven:3-jdk-8-onbuild  
MAINTAINER mikael@sennerholm.net  
  
ENV SE_CAGLABS_WELCOME_SERVER_ENVIRONMENT local  
EXPOSE 8080  
CMD java -jar target/welcome-server-1-SNAPSHOT.jar

