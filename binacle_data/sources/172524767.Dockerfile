# Set the base image to Ubuntu
FROM mhart/alpine-node:4.3.1

# File Author / Maintainer
MAINTAINER Ben Coe

COPY ./replicated/es-follower/start.sh /etc/npme/start.sh
WORKDIR /etc/npme

RUN echo '@npm:registry=https://enterprise.npmjs.com/' > ~/.npmrc
RUN npm install @npm/registry-follower
RUN apk update
RUN apk add curl
RUN apk add bash
RUN rm -rf /var/cache/apk/*

CMD ["/etc/npme/start.sh"]
