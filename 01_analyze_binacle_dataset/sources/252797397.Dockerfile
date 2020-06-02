FROM node:6-alpine  
  
LABEL maintainer "David Clutter <cluttered.code@gmail.com>"  
RUN apk update \  
&& apk upgrade \  
&& apk add \--no-cache git \  
&& npm install -g polymer-cli bower

