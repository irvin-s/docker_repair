FROM node:10
LABEL maintainer="diogolmenezes@gmail.com"
USER root

RUN mkdir -p /usr/src/elastic-butler
WORKDIR /usr/src/elastic-butler

COPY . /usr/src/elastic-butler/
RUN npm install

CMD ["node", "index"]