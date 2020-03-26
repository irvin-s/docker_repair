FROM node:6.11.2-stretch  
  
ENV POSTGRES_PORT=5432  
RUN apt-get update && \  
apt-get install -y curl  
  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install topojson  
RUN npm install https://github.com/CUUATS/tilesplash.git  
RUN npm install && npm cache clean  
COPY bikemoves.proto /usr/src/app/bikemoves.proto  
COPY ./src /usr/src/app/src  
COPY ./scripts /usr/src/app/scripts  
COPY webpack.config.js webpack.config.js  
RUN npm run build  
  
VOLUME /osrm  
EXPOSE 8888  
CMD [ "npm", "start" ]  

