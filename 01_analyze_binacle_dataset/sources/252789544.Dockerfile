FROM ubuntu:14.04  
RUN apt-get clean && apt-get update && apt-get install git curl -y  
RUN curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -  
RUN apt-get -y install nodejs -y  
RUN npm install -g nodemon  
  
RUN mkdir /opt/duraark-pointcloud-viewer  
  
COPY ./app /opt/duraark-pointcloud-viewer/app  
COPY ./public /opt/duraark-pointcloud-viewer/www  
  
WORKDIR /opt/duraark-pointcloud-viewer/app  
  
EXPOSE 5016  
RUN npm install  
  
VOLUME /var/lib/docker  
  
CMD ["npm", "start"]  

