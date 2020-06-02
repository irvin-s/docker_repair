FROM node  
MAINTAINER Pablo Castro <pablo.castro@vacmatch.com>  
  
RUN apt-get -y update && apt-get install -y nodejs && apt-get install -y npm  
RUN npm install -g gulp  
RUN mkdir -p /usr/vacmatch-mobile  
WORKDIR /usr/vacmatch-mobile  
COPY . /usr/vacmatch-mobile  
  
RUN npm install  
RUN gulp build  
RUN gulp build  
EXPOSE 8080  
CMD gulp run  

