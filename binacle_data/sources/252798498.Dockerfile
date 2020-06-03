FROM node:0.10.32  
MAINTAINER denverdino@gmail.com  
RUN npm install bower -g  
COPY . /opt/docker-image-registry-console  
WORKDIR /opt/docker-image-registry-console  
EXPOSE 3000  
ENV PRIVATE_REGISTRY_URL http://192.168.1.1:5000  
ENV DOCKER_HUB_USER USER_NAME  
ENV DOCKER_HUB_PASSWORD PASSWORD  
RUN npm install  
RUN bower install --allow-root  
CMD npm start  

