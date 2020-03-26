FROM mhart/alpine-node:latest  
  
RUN mkdir /src  
WORKDIR /src  
COPY package.json /src/  
COPY bower.json /src/  
  
RUN npm install \  
&& apk add --no-cache git \  
&& node_modules/.bin/bower install --allow-root \  
&& apk del git  
  
COPY . /src  
  
EXPOSE 80  
CMD [ "node", "server.js" ]  

