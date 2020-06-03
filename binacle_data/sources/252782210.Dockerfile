# docker build -t node-socialscreen .  
# docker run -p 3000:3000 -p3001:3001 node-socialscreen  
FROM node:8-alpine  
MAINTAINER ilari.liukko@iki.fi  
  
# Workdir  
WORKDIR /app/  
# Add package.json  
ADD package.json /app/package.json  
# Install packages  
RUN npm install  
# Add the rest of the project  
ADD . /app  
  
# Expose UI and API ports  
EXPOSE 3000  
EXPOSE 3001  
# Start project  
CMD npm run all  

