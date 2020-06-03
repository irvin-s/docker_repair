FROM node:9.2.1

ENV APP_ROOT /usr/src/koa-sample-ap

COPY . $APP_ROOT
WORKDIR $APP_ROOT

RUN npm install && npm cache verify

EXPOSE 3000

CMD ["npm", "start"]
