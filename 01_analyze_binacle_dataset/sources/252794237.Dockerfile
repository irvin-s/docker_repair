FROM node:10-alpine  
LABEL maintainer="DasCodeMonster <pl.lkw.01@gmail.com>"  
  
WORKDIR /usr/src/MyBotV2  
COPY package.json package-lock.json ./  
  
RUN apk add --update \  
&& apk add \--no-cache --virtual .build-deps git curl python g++ make \  
&& apk add ffmpeg \  
&& npm install \  
&& apk del .build-deps  
  
COPY . .  
  
ENV Token= \  
PREFIX=  
  
CMD [ "node", "index.js" ]

