FROM node:alpine

MAINTAINER Popov Gennadiy <me@westtrade.tk>

COPY . /etc/cleantalk
WORKDIR /etc/cleantalk


RUN npm install --production
EXPOSE 9081

CMD ["node", "./examples/httpServer"]
