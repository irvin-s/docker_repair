FROM node  
  
RUN apt-get update && apt-get -y install libkrb5-dev  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY package.json /usr/src/app/  
RUN npm install  
COPY bower.json /usr/src/app/  
COPY .bowerrc /usr/src/app/  
RUN ./node_modules/bower/bin/bower install --allow-root  
COPY . /usr/src/app  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

