FROM mhart/alpine-node:4.2.4

MAINTAINER Capgemini

WORKDIR /src

RUN apk add --update make gcc g++ python

COPY dist .

ENV NODE_ENV production

RUN npm install

RUN apk del make gcc g++ python && \
  rm -rf /tmp/* /var/cache/apk/* /root/.npm /root/.node-gyp

EXPOSE 8080
CMD ["npm", "start"]
