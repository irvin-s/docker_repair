FROM node:8

MAINTAINER riskers

RUN mkdir /src

WORKDIR /src
ADD src /src
RUN npm install --registry=https://registry.npm.taobao.org

EXPOSE 3000

CMD ["node", "app.js"]