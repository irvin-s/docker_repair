FROM node:boron  
  
# Create app directory  
RUN mkdir -p /usr/src/moonar-lander  
WORKDIR /usr/src/moonar-lander  
  
# Install moonar-lander dependencies  
COPY package.json /usr/src/moonar-lander/  
COPY backend /usr/src/moonar-lander/backend/  
COPY frontend /usr/src/moonar-lander/frontend/  
  
RUN npm install  
RUN npm run build  
  
EXPOSE 4711  
CMD [ "node", "./build/backend/index.js" ]  

