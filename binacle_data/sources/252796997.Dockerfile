FROM node:latest  
MAINTAINER Stefan Dimitrov <stefan@cloudeity.com>  
  
ADD . /app  
WORKDIR /app  
RUN npm install  
RUN apt-get update  
RUN apt-get install -y moreutils  
  
EXPOSE 3000  
COPY ./entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

