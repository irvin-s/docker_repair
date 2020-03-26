FROM maven:alpine AS builder  
MAINTAINER javi@programar.cloud  
ADD . /app  
WORKDIR /app  
  
RUN mvn clean package  
  
# ------------------------------------------------------  
FROM anapsix/alpine-java  
MAINTAINER Javi Moreno <javi.moreno@capside.com>  
  
COPY \--from=builder /app/target/*.jar /usr/share/app.jar  
  
EXPOSE 8080  
ENTRYPOINT ["java", "-jar", "/usr/share/app.jar"]  

