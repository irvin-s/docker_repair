FROM java:8  
MAINTAINER seeni45@gmail.com  
  
# VOLUME /tmp  
#Copy a prebuilt java application to the container  
ADD target/springswagger-0.1.jar app.jar  
  
RUN bash -c 'touch /app.jar'  
  
# Expose HTTP port 8080 for tomcat triggered by Spring Boot  
EXPOSE 9090  
# bring the application up and running.  
ENTRYPOINT ["java","-jar","/app.jar"]  

