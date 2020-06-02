FROM node:9.0
MAINTAINER lwyj123 <443474713@qq.com>

RUN mkdir -p /usr/share/nginx/wuanlife
WORKDIR /usr/share/nginx/wuanlife

COPY package.json /usr/share/nginx/wuanlife
# set taobao source package
RUN npm config set registry https://registry.npm.taobao.org
RUN npm install
COPY . /usr/share/nginx/wuanlife

RUN npm run build:prod