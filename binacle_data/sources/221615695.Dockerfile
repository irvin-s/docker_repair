# Dash on Alpine
#
# VERSION 0.3.0

FROM node:8
MAINTAINER Hans Klunder <hans.klunder@bigfoot.com>
RUN mkdir -p /home/node/app/db

WORKDIR /home/node/app/
COPY ./ /home/node/app/

RUN npm install --production
RUN chown node /home/node/app/db

EXPOSE 8080
EXPOSE 5984
USER node
ENTRYPOINT ["/bin/sh","/home/node/app/docker/startup.sh"]
