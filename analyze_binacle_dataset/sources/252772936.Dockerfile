FROM mhart/alpine-node:latest  
  
MAINTAINER Kevin Richter<me@kevinrichter.nl>  
  
WORKDIR /app  
  
COPY . .  
  
RUN npm install --only=production --no-package-lock  
  
ENV SCHEDULE "0 0 */2 * * *"  
ENV DOWNLOAD_FOLDER ""  
ENV TRANSMISSION_HOST "127.0.0.1"  
ENV TRANSMISSION_PORT "9091"  
ENV TRANSMISSION_USERNAME ""  
ENV TRANSMISSION_PASSWORD ""  
VOLUME /app/config  
  
CMD ["npm", "run", "scheduled"]  

