FROM node:8-alpine  
  
MAINTAINER dishuostecli "dishuostec@gmail.com"  
ARG ALPINE_REPO=http://dl-cdn.alpinelinux.org  
  
RUN ver=$(cat /etc/alpine-release | awk -F '.' '{printf "%s.%s", $1, $2;}') \  
&& repos=/etc/apk/repositories \  
&& mv -f ${repos} ${repos}_bk \  
&& echo "${ALPINE_REPO}/alpine/v${ver}/main" > ${repos} \  
&& echo "${ALPINE_REPO}/alpine/v${ver}/community" >> ${repos} \  
&& apk add --no-cache tzdata \  
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \  
&& echo Asia/Shanghai > /etc/timezone  
  

