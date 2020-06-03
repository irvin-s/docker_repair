FROM alpine/git as clone  
WORKDIR /app  
RUN git clone https://github.com/amitmindstix/spring-boot-rest-example.git  
WORKDIR /app/spring-boot-rest-example  
RUN git checkout development  
  
FROM maven:3.5-jdk-8-alpine as build  
WORKDIR /app  
COPY \--from=clone /app/spring-boot-rest-example /app  
RUN mvn install  
  
FROM openjdk:8-jre-alpine  
MAINTAINER Amit Mujawar <amit.mujawar@mindstix.com>  
WORKDIR /app  
COPY \--from=build /app/target/spring-boot-rest-example-0.5.0.war /app  
ENTRYPOINT ["java", "-jar", "spring-boot-rest-example-0.5.0.war"]  
  
EXPOSE 8090  

