FROM node  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install -g http-server bower bower-art-resolver  
RUN npm install  
COPY . /usr/src/app/  
RUN bower install --allow-root  
  
ENV NODE_ENV production  
  
EXPOSE 8080  
CMD cd ./app; http-server;

