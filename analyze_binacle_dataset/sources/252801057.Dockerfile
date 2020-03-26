FROM node:7-slim  
ENV NODE_ENV production  
  
# Create app directory  
RUN mkdir -p /app/  
WORKDIR /app/  
COPY package.json /app/  
RUN npm install  
  
ADD . /app/  
  
EXPOSE 8080  
# Build at runtime to grab environment variables  
CMD npm run build && npm start  

