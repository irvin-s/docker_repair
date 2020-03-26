FROM node:4.4-wheezy  
MAINTAINER Claude Seguret <claude.seguret@gmail.com>  
  
ENV ELASTICSEARCH_PROTO http  
ENV ELASTICSEARCH_HOST **None**  
ENV ELASTICSEARCH_PORT 9200  
ENV ELASTICSEARCH_USER **None**  
ENV ELASTICSEARCH_PASS **None**  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
EXPOSE 1337:1337  
CMD [ "npm", "start" ]  

