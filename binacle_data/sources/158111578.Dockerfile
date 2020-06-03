FROM node:5.4-wheezy
MAINTAINER junjun16818
WORKDIR /app
ADD ./package.json /app/
RUN npm install --production
EXPOSE 80
ADD ./docker /usr/local/bin/docker
ADD . /app
CMD node index.js
