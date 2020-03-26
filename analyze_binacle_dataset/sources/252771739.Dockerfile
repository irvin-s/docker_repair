FROM node:0.12  
# Install Bower  
RUN npm install -g bower \  
&& npm cache clear  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install package.json dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Install bower components  
COPY bower.json .bowerrc /usr/src/app/  
RUN bower install --config.interactive=false \--allow-root  
  
COPY . /usr/src/app  
  
EXPOSE 8080  
CMD [ "npm", "start" ]  

