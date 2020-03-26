FROM lwieske/java-8  
MAINTAINER Alexander Lukyanchikov <sqshq@sqshq.com>  
  
ADD ./target/demo-authority-service.jar /app/  
CMD ["java", "-Xmx200m", "-jar", "/app/demo-authority-service.jar"]  
  
EXPOSE 5000  

