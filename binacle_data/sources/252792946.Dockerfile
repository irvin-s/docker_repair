FROM mhart/alpine-node:8.9  
LABEL maintainer="Eric Chang <chiahan1123@gmail.com>"  
RUN apk update && apk upgrade && \  
apk add \--no-cache make gcc g++ python git && \  
rm -rf /var/cache/apk/*  
  

