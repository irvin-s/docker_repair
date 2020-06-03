FROM ubuntu:17.10  
RUN apt-get update  
RUN apt-get -y install npm  
RUN apt-get -y install nodejs  
COPY /app /uptime  
WORKDIR /uptime/  
  
RUN npm install  

