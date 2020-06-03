FROM ubuntu:15.04  
MAINTAINER Ash Prosser <ash@wearemothership.com>  
  
#NodeJS  
RUN apt-get install curl -y  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -  
RUN apt-get install -y nodejs  
RUN apt-get install -y build-essential  
  
#PM2  
RUN npm install pm2 -g  
  
COPY ./package.json /usr/local/var/sourceit/package.json  
WORKDIR /usr/local/var/sourceit  
RUN npm install --production  
  
WORKDIR /usr/local/var/sourceit/app  
ADD . /usr/local/var/sourceit/app  
  
EXPOSE 3000  
EXPOSE 4242  
VOLUME ["/usr/local/var/sourceit/data/uploads"]  
  
CMD ["npm", "run-script", "start"]

