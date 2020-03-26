FROM node:8.4
RUN mkdir vue
WORKDIR vue
COPY package.json /vue
COPY .babelrc /vue
RUN npm config set registry https://registry.npm.taobao.org
RUN npm install
EXPOSE 9000
