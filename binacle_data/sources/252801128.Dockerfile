FROM node:8  
RUN mkdir -p /usr/src/sportsstore  
COPY dist /usr/src/sportsstore/app  
COPY src/middleware /usr/src/sportsstore/middleware  
COPY src/data /usr/src/sportsstore/data  
COPY deploy-server.js /usr/src/sportsstore/server.js  
COPY deploy-package.json /usr/src/sportsstore/package.json  
  
WORKDIR /usr/src/sportsstore  
RUN npm install  
EXPOSE 3000  
EXPOSE 3500  
CMD ["npm", "start"]  

