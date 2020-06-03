# DOCKER-VERSION 0.6.1  
FROM ubuntu:14.04  
RUN sudo apt-get update && sudo apt-get -y install nodejs npm  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
RUN npm install -g grunt-cli  
  
ADD . /src  
  
RUN cd /src; npm install; grunt jade:dev less:dev  
  
EXPOSE 8080  
CMD ["node", "src/server.js"]  

