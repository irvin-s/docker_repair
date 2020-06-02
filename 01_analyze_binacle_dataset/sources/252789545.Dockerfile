FROM duraark/microservice-base  
  
MAINTAINER Martin Hecher <martin.hecher@fraunhofer.at>  
  
# Bundle app, install, expose and finally run it  
COPY ./ /opt/duraark-sda  
WORKDIR /opt/duraark-sda  
  
EXPOSE 5013  
RUN npm install  
  
CMD ["sails", "lift", "--prod"]  

