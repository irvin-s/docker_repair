FROM node:6  
RUN npm install -g statsd@0.8.0  
  
EXPOSE 8125/udp  
  
CMD statsd /statsd/config.js  

