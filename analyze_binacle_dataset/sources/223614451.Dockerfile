FROM node:4.6.1-slim
MAINTAINER VividCloud

COPY bundle/ /bundle/
WORKDIR /bundle

RUN (cd programs/server && npm install)

ENV PORT 80
EXPOSE 80
CMD node main.js
