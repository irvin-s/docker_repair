FROM dottgonzo/mininode  
MAINTAINER Dario Caruso <dev@dariocaruso.info>  
COPY ./package.json /app  
RUN npm i --production  
COPY ./index.js /app  
COPY ./server.js /app  
COPY ./bin /app/bin  
EXPOSE 18496  
CMD npm start

