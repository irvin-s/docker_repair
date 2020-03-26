FROM mhart/alpine-node:latest  
  
  
RUN mkdir /app && mkdir /aux  
RUN apk add --no-cache git && \  
git clone https://github.com/celaus/pi-camera-api /app && \  
cd /app && \  
npm install && \  
apk del git  
  
VOLUME /aux  
  
EXPOSE 6300  
WORKDIR /app  
  
CMD ["npm", "start"]

