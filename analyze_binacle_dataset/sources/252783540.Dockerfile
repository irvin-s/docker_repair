FROM node:latest  
  
RUN mkdir app-malvinas-russell  
ADD package.json /app-malvinas-russell/  
WORKDIR /app-malvinas-russell  
RUN npm install  
ADD server.js /app-malvinas-russell/  
ADD sw-precache-config.json /app-malvinas-russell/  
ADD makeindex.js /app-malvinas-russell/  
ADD initga.js /app-malvinas-russell/  
ADD src/ /app-malvinas-russell/src/  
ADD build/ /app-malvinas-russell/build/  
ADD tmp/ /app-malvinas-russell/tmp/  
ADD main.css /app-malvinas-russell/  
RUN npm run build  
VOLUME /app-malvinas-russell/  
CMD ["node","server.js"]  

