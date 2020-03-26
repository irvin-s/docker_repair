FROM node:latest  
  
RUN \  
npm install -g forever  
  
ENTRYPOINT ["forever"]  

