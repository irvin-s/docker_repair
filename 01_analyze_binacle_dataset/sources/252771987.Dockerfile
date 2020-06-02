FROM openjdk:8-alpine  
MAINTAINER atze.devries@naturalis.nl  
RUN mkdir /payload  
RUN apk add --no-cache bash  
WORKDIR /payload  
ADD software software  
RUN mkdir data  
WORKDIR /payload/software  
ADD version version  

