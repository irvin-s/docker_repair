FROM node:4.4.7  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
ONBUILD COPY package.json /usr/src/app/  
ONBUILD RUN npm install  
ONBUILD RUN npm install -g gulp  
ONBUILD RUN npm install -g jspm  
ONBUILD RUN npm install -g unzip  
ONBUILD COPY . /usr/src/app  
ONBUILD RUN jspm config registries.github.auth #put in github token here  
ONBUILD RUN jspm install -y  
ONBUILD RUN gulp build  
  
CMD [ "gulp", "watch" ]  

