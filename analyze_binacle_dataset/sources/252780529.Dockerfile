FROM babanomania/primertech-base:latest  
  
WORKDIR Ex5_Angular_Rest/AngularDemo  
RUN mvn clean package  
  
EXPOSE 8080  
CMD ["mvn", "jetty:run"]  
  

