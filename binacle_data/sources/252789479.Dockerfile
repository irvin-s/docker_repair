FROM openjdk:8-jre-alpine  
  
RUN mkdir /app  
  
ADD *.war /app/app.war  
  
EXPOSE 8761  
ENTRYPOINT ["java", "-jar", "/app/app.war"]

