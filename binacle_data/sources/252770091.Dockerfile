FROM alpine/git as clone  
WORKDIR /app  
RUN git clone https://github.com/arunk16/anagram-moj.git  
  
FROM maven:3.5-jdk-8-alpine as build  
WORKDIR /app  
COPY \--from=clone /app/anagram-moj /app  
RUN mvn install  
  
FROM openjdk:8-jre-alpine  
ENV PORT 8080  
EXPOSE 8080  
WORKDIR /app  
COPY \--from=build /app/target/*.jar /opt/app.jar  
WORKDIR /opt  
CMD ["java", "-jar", "app.jar"]  

