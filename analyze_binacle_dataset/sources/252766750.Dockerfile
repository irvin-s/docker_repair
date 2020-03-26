FROM maven:3.5-jdk-8 as BUILD  
  
COPY src /usr/src/posts_analyzer/src  
COPY pom.xml /usr/src/posts_analyzer  
RUN mvn -f /usr/src/posts_analyzer/pom.xml clean install  
  
FROM openjdk:8  
COPY \--from=BUILD /usr/src/posts_analyzer/target/*.jar /app.jar  
EXPOSE 8080  
ENTRYPOINT ["java", "-jar", "/app.jar"]

