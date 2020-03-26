FROM node:0.12.0  
MAINTAINER Boopathi Rajaa <me@boopathi.in>  
  
RUN mkdir /presentation  
  
WORKDIR /presentation  
  
ENV PORT 80  
ADD . /presentation/  
  
RUN npm install  
RUN ./node_modules/.bin/webpack  
  
VOLUME ['/presentation/db']  
  
EXPOSE 80  
ENTRYPOINT npm start  

