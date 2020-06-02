FROM babanomania/primertech-base:latest  
  
WORKDIR Ex3_JSF/MyFacesDemo  
RUN mvn clean package  
  
EXPOSE 8080  
CMD ["mvn", "jetty:run"]  
  

