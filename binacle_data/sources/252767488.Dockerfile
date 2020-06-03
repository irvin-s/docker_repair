#FROM node:0.10-slim  
FROM node  
  
# Bundle app source  
COPY . /src  
# Install app dependencies  
RUN cd /src; npm install  
  
WORKDIR /src  
#EXPOSE 8080  
CMD ["node", "server.js"]

