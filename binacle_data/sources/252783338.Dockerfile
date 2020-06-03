FROM node:latest  
  
COPY . /app-sources  
  
WORKDIR /app-sources  
  
RUN npm install  
  
RUN npm run build --env=prod  
  
RUN cp -R /app-sources/dist /webapp-volume/  
  
VOLUME /webapp-volume  
  
ENTRYPOINT ["cp", "-R", "/webapp-volume", "/webapp"]  

