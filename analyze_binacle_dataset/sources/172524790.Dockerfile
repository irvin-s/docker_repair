# Set the base image to Ubuntu
FROM mhart/alpine-node:4.4.7

# File Author / Maintainer
MAINTAINER Ben Coe

COPY ./replicated/registry-follower/start.sh /etc/npme/start.sh
COPY ./replicated/registry-follower/aggregate /etc/periodic/15min/aggregate
WORKDIR /etc/npme

RUN echo '@npm:registry=https://enterprise.npmjs.com/' > ~/.npmrc
RUN npm install @npm/relational-registry-follower@2.4.1
COPY ./replicated/registry-follower/config-development.js /etc/npme/node_modules/@npm/relational-registry-follower/node_modules/@npm/registry-relational-models/config-development.js
COPY ./replicated/registry-follower/config-development.js /etc/npme/node_modules/@npm/relational-registry-follower/config-development.js
COPY ./replicated/registry-follower/bootstrap.js /etc/npme/node_modules/@npm/relational-registry-follower/node_modules/@npm/registry-relational-models/bootstrap.js
RUN apk update
RUN apk add curl
RUN apk add bash
RUN rm -rf /var/cache/apk/*

CMD ["/etc/npme/start.sh"]
