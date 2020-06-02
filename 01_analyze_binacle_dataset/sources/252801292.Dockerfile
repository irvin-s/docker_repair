FROM ubuntu:16.04  
MAINTAINER Alessandro Oliveira <alessandro@dynamicflow.com.br>  
RUN apt-get update && apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_6.x | /bin/bash -  
RUN apt-get update && apt-get install -y git nodejs python build-essential  
ENV STATICACHE_BIN /bin/lib/staticache  
ENV STATICACHE_VAR /var/lib/staticache  
ENV NODE_ENV prod  
ENV STATICACHE_DB mysql://username:password@localhost:3306/database  
COPY server $STATICACHE_BIN/server/  
COPY conf $STATICACHE_BIN/conf/  
COPY package.json $STATICACHE_BIN/  
WORKDIR $STATICACHE_BIN  
RUN npm install  
RUN apt-get remove -y --purge git python build-essential curl && apt-get clean  
EXPOSE 8080  
VOLUME [ $STATICACHE_VAR ]  
CMD node server/app.js  

