FROM node:6
MAINTAINER ShiftForward <info@shiftforward.eu>

RUN mkdir -p /app
WORKDIR /app

ENV NODE_ENV production

ADD package.json /app/package.json
RUN npm install

ADD config /app/config
ADD src /app/src
ADD .babelrc /app/.babelrc

EXPOSE 8300 3000
ENTRYPOINT ["npm", "start", "--"]
