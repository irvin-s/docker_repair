FROM node:8  
MAINTAINER Abakus Webkom <webkom@abakus.no>  
  
ENV NODE_ENV production  
  
RUN mkdir -p /app  
COPY . /app/  
WORKDIR /app  
  
RUN set -e \  
&& yarn  
  
ENTRYPOINT ["bin/hubot"]  

