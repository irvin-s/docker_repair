FROM node:8-alpine
MAINTAINER reruin

ADD . /app/
WORKDIR /app

RUN npm install

ENV HOST 0.0.0.0
ENV PORT 3003

EXPOSE 3003

CMD ["npm", "start"]