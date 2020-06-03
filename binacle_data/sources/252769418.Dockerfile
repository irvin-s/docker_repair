FROM maven:alpine as deps  
RUN mkdir /app  
WORKDIR /app  
COPY pom.xml .  
ENV MAVEN_OPTS=" -XX:+TieredCompilation -XX:TieredStopAtLevel=1"  
RUN mvn -T 3C install  
  
FROM maven:alpine as build  
RUN mkdir /app  
WORKDIR /app  
COPY \--from=deps "/root/.m2" "/root/.m2"  
COPY pom.xml .  
COPY src ./src  
ENV MAVEN_OPTS=" -XX:+TieredCompilation -XX:TieredStopAtLevel=1"  
RUN mvn --offline package  
  
FROM openjdk:jre-alpine as app  
RUN mkdir /app  
WORKDIR /app  
COPY \--from=build "/app/target/*-jar-with-dependencies.jar" "/app/app.jar"  

