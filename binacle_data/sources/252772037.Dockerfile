FROM node:9.11-alpine  
LABEL name="greenlight"  
LABEL description="Greenlight Command Line Interface"  
LABEL maintainer="Ahmad Nassri <ahmad@ahmadnassri.com>"  
  
RUN apk add --update --no-cache --virtual docker  
  
COPY app /greenlight/app  
COPY package.json /greenlight/  
COPY package-lock.json /greenlight/  
  
WORKDIR /greenlight/  
RUN npm install --production  
RUN npm link  
  
ENTRYPOINT ["greenlight"]  

