FROM node  
MAINTAINER [Alejandro Baez](https://twitter.com/a_baez)  
  
RUN git clone -b custom https://github.com/abaez/haste-server.git /opt/haste  
  
ADD add/config.js /opt/haste/  
#ADD add/index.html /opt/haste/static/  
ADD add/highlight.min.js /opt/haste/static/  
WORKDIR /opt/haste  
  
RUN npm install  
  
expose 7777  
cmd ["npm", "start"]  

