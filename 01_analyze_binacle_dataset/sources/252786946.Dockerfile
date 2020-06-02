FROM node:alpine  
RUN apk update  
RUN apk upgrade  
RUN apk add git  
WORKDIR /root  
RUN git clone https://github.com/thebradad1111/arbot.git  
WORKDIR arbot  
RUN npm install  
RUN chmod +x docker-entrypoint.sh  
RUN chmod +x settoken.sh  
ENTRYPOINT sh -c ./docker-entrypoint.sh  

