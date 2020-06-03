FROM keymetrics/pm2:8-alpine  
MAINTAINER Carlos Castillo  
  
RUN apk update && apk add ffmpeg && rm -rf /var/cache/apk/*  
  
RUN ["mkdir", "/opt/app"]  
WORKDIR /opt/app  
  
COPY *.json /opt/app/  
  
ENV NPM_CONFIG_LOGLEVEL error  
RUN npm install  
  
COPY config /opt/app/config  
COPY src /opt/app/src  
COPY views /opt/app/views  
COPY public /opt/app/public  
  
RUN npm run build  
  
ENV PORT 3000  
EXPOSE 3000  
CMD [ "pm2-docker", "start", "pm2.json" ]  

