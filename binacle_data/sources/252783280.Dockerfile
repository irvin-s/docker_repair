FROM node:latest  
ARG JSPM_GITHUB_AUTH_TOKEN  
RUN mkdir /usr/share/frontend  
ADD . /usr/share/frontend  
WORKDIR /usr/share/frontend  
  
RUN npm install  
ENV PATH=$PATH:node_modules/.bin  
RUN typings install  
RUN jspm config registries.github.auth $JSPM_GITHUB_AUTH_TOKEN  
RUN gulp build --production  
RUN chmod -R 755 /usr/share/frontend/dist  
  

