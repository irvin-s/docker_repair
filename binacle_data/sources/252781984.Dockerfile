# docker build ./node_essentials -t node_essentials  
FROM node:6.11-alpine  
MAINTAINER Koji Carvalho <stylethewalker@gmail.com.br>  
  
RUN apk update && apk upgrade \  
&& apk add \--no-cache alpine-sdk python unzip git

