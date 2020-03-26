FROM mhart/alpine-node:latest

RUN apk add --update git && \
  rm -rf /tmp/* /var/cache/apk/* && \
  yarn global add now

WORKDIR /pullmeapp

COPY package.json .
RUN yarn --production

ADD . .

EXPOSE 3000

CMD npm start