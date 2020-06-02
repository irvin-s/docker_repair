FROM node:8.3

MAINTAINER ZZES-ZVD "renzw@zzes1314.cn" 

RUN npm install -g cnpm --registry=https://registry.npm.taobao.org

COPY package.json /
RUN cnpm install

RUN node api.js
RUN node iotTcp.js

EXPOSE 3000 4001  
