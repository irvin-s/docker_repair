FROM node:4.3.0  
MAINTAINER Srinath Janakiraman <me@vjsrinath.com>  
  
ENV VERSION=1.0.4  
ENV WORK_DIR=/srv/www/ludicrum-authentication  
ENV DB=mongodb://mongodb:27017/ludicrum  
ENV GATEWAY_HOSTS=http://kong:8001  
ENV AMQP_SERVICE_HOST=amqp://guest:guest@rabbitmq:5672  
ENV PORT=4000  
## ENV NODE_ENV  
## Expose port 4000  
EXPOSE ${PORT}  
  
  
##RUN apt-get install build-essential libavahi-compat-libdnssd-dev  
RUN apt-get update \  
&& npm install pm2@latest -g  
  
##Creating working directory  
RUN mkdir -p ${WORK_DIR};  
##Setting working directory  
WORKDIR ${WORK_DIR}  
  
##Copy package file to working directory  
COPY package.json ./  
##Install dependencies defined in package file  
RUN npm install  
##Copy rest of the files to working directory  
COPY [".", "./"]  
  
##Set the entry point to node  
ENTRYPOINT ["node"]  
##Set the arguments to be passed to the entrypoint  
CMD ["index.js"]  

