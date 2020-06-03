FROM node:8.4-alpine  
MAINTAINER DUONG Dinh Cuong <cuong3ihut@gmail.com>  
  
ENV TAG_VERSION 0.0.0  
COPY . /opt/openearth-esp-historical-sensor-data  
RUN cd /opt/openearth-esp-historical-sensor-data && npm install  
  
WORKDIR "/opt/openearth-esp-historical-sensor-data/"  
  
EXPOSE 8081  
CMD ["npm","start"]

