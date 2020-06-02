FROM node  
  
COPY app /data/app  
COPY index.js /data/index.js  
COPY package.json /data/package.json  
COPY certs /data/certs  
COPY public /data/public  
COPY views /data/views  
COPY log4js.json /data/log4js.json  
  
WORKDIR /data  
RUN npm install  
  
VOLUME /data/acme-challenge  
VOLUME /data/certs  
VOLUME /data/logs  
  
EXPOSE 8080  
EXPOSE 8443  
CMD npm start

