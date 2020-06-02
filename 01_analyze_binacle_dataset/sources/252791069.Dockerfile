FROM node:4.6.1  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ARG NODE_ENV  
ENV NODE_ENV $NODE_ENV  
COPY package.json /usr/src/app/  
RUN npm install  
COPY . /usr/src/app  
RUN npm run build-glyphs  
  
VOLUME /var/data  
EXPOSE 8080  
CMD [ "npm", "start" ]  

