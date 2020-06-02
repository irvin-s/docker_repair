FROM chriscamicas/node-xvfb:latest  
  
RUN apt-get update && apt-get install -y unixodbc unixodbc-dev  
  
CMD ["node"]

