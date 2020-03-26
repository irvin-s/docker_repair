FROM node:8.11.4-slim

WORKDIR /homeeup
COPY . /homeeup

RUN yarn install --prod

CMD node /homeeup/bin/homeeup

EXPOSE 2001