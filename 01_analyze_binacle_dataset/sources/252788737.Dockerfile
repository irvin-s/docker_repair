FROM node:6.10  
RUN mkdir -p /opt/bukget  
WORKDIR /opt/bukget  
  
ADD package.json ./package.json  
RUN npm install --build-from-source  
  
# Add source code  
ADD . .  
  
ENV NODE_ENV=production  
CMD npm rebuild && npm start  

