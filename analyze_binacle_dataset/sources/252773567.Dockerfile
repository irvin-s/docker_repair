FROM node:4.4.2  
MAINTAINER alienblog@outlook.com  
  
RUN \  
mkdir -p /opt/p2p  
  
ADD . /opt/p2p  
  
WORKDIR /opt/p2p  
  
RUN npm install  
  
ENV MYSQL_ADDR localhost  
ENV MYSQL_PORT 3306  
ENV MYSQL_USER p2pspider  
ENV MYSQL_PWD p2pspider  
ENV MYSQL_DBNAME p2pspider  
  
EXPOSE 6881  
ENTRYPOINT ["node", "app.js"]

