FROM node:5.12.0  
WORKDIR .  
RUN npm install  
RUN npm install -g cordova ionic  
EXPOSE 8100  
EXPOSE 35729  
CMD ["ionic", "serve"]

