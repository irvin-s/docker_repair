FROM duraark/microservice-base  
  
MAINTAINER Martin Hecher <martin.hecher@fraunhofer.at>  
  
RUN mkdir -p /opt/duraark-digitalpreservation  
COPY ./ /opt/duraark-digitalpreservation  
  
WORKDIR /opt/duraark-digitalpreservation  
  
EXPOSE 5015  
RUN npm install  
  
CMD ["sails", "lift", "--prod"]  

