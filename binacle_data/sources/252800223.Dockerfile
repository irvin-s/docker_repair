FROM node:8.9-alpine as build  
ARG ALPINE_REPO=http://dl-cdn.alpinelinux.org  
WORKDIR /app  
RUN ver=$(cat /etc/alpine-release | awk -F '.' '{printf "%s.%s", $1, $2;}') \  
&& repos=/etc/apk/repositories \  
&& mv -f ${repos} ${repos}_bk \  
&& echo "${ALPINE_REPO}/alpine/v${ver}/main" > ${repos} \  
&& echo "${ALPINE_REPO}/alpine/v${ver}/community" >> ${repos} \  
&& apk add --no-cache tzdata \  
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \  
&& echo Asia/Shanghai > /etc/timezone \  
&& apk add --no-cache git openssh-client  
COPY . /app/  
RUN npm install --only=production \  
&& cp -R node_modules prod_node_modules \  
&& npm install \  
&& npm run build  
  
FROM node:8.9-alpine  
MAINTAINER dishuostecli "dishuostec@gmail.com"  
ARG ALPINE_REPO=http://dl-cdn.alpinelinux.org  
WORKDIR /app  
USER root  
RUN ver=$(cat /etc/alpine-release | awk -F '.' '{printf "%s.%s", $1, $2;}') \  
&& repos=/etc/apk/repositories \  
&& mv -f ${repos} ${repos}_bk \  
&& echo "${ALPINE_REPO}/alpine/v${ver}/main" > ${repos} \  
&& echo "${ALPINE_REPO}/alpine/v${ver}/community" >> ${repos} \  
&& apk add --no-cache tzdata \  
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \  
&& echo Asia/Shanghai > /etc/timezone  
COPY cron /app/cron/  
COPY package.json /app/  
COPY \--from=build /app/lib /app/lib  
COPY \--from=build /app/prod_node_modules /app/node_modules  
EXPOSE 3000  
CMD ["npm", "start"]  

