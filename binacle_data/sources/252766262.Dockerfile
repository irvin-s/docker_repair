FROM maven:3.3-jdk-7  
WORKDIR .  
CMD ["mvn", "tomcat7:run"]

