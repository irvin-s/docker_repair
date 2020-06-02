FROM node:4.8.1

RUN apt-get update && \
    apt-get install -y cron supervisor

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

ONBUILD ARG NODE_ENV
ONBUILD ENV NODE_ENV $NODE_ENV
ONBUILD COPY ../../package.json /usr/src/app/
ONBUILD RUN npm install && npm cache clean
ONBUILD COPY . /usr/src/app

COPY supervisord.conf /etc/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisord.conf
