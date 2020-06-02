FROM babanomania/primertech-base:latest  
  
WORKDIR Ex4_JQuery_Ajax/JQueryDemo  
RUN mvn clean package  
  
EXPOSE 8080  
CMD ["mvn", "jetty:run"]  
  

