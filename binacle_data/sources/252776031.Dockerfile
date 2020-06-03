FROM openjdk:8-jdk-alpine  
  
RUN mkdir -p /app/build  
RUN mkdir -p /app/run  
WORKDIR /app/build  
  
RUN apk add --no-cache maven  
COPY . .  
  
RUN mvn clean package  
RUN cp target/ISStatusBot.jar /app/run/  
  
WORKDIR /app/run  
ENTRYPOINT ["java", "-jar", "ISStatusBot.jar"]

