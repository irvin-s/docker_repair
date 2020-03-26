FROM openjdk:8-jre  
  
COPY build/libs/taxi-1.0-SNAPSHOT-all.jar /opt/taxi.jar  
  
EXPOSE 4567  
CMD ["java", "-jar", "/opt/taxi.jar"]

