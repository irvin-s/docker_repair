FROM errordeveloper/iojs-minimal-runtime:v1.0.1  
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>  
ADD . /srv/app  
WORKDIR /srv/app  
RUN npm install  
EXPOSE 80  
ENTRYPOINT ["node", "index.js"]  

