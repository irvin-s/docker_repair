FROM stackbrew/ubuntu:14.04  
MAINTAINER Dale-Kurt Murray "dalekurt.murray@gmail.com"  
# Build environment  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y curl  
  
RUN curl -sL https://deb.nodesource.com/setup_0.12 | bash -  
  
RUN apt-get install -y nodejs git git-core  
  
WORKDIR /app  
ADD node-js-sample/package.json /app/  
RUN npm install  
ADD node-js-sample /app  
  
EXPOSE 5000  
ENTRYPOINT ["npm", "start"]  
CMD []  

