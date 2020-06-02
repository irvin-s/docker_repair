FROM duraark/microservice-base  
  
MAINTAINER Martin Hecher <martin.hecher@fraunhofer.at>  
  
RUN mkdir /opt/duraark-sessions  
WORKDIR /opt/duraark-sessions  
  
COPY ./package.json /opt/duraark-sessions/package.json  
RUN npm install  
  
COPY . /opt/duraark-sessions  
  
CMD ["npm", "start"]  
  
EXPOSE 5011  

