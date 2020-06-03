# Set the base image to Ubuntu
FROM mhart/alpine-node:6.11

# File Author / Maintainer
MAINTAINER Ben Coe


COPY ./replicated/start.sh /etc/npme/start.sh
COPY ./replicated/npme-update-license.sh /usr/local/bin/npme-update-license.sh
COPY ./replicated/install-couch-app.sh /etc/npme/install-couch-app.sh
WORKDIR /etc/npme

RUN echo '@npm:registry=https://enterprise.npmjs.com/' > ~/.npmrc
RUN npm install npm-registry-couchapp@npmo
RUN npm install @npm/registry-frontdoor@2.12.1
RUN npm install @npm/couch-url-rewrite-proxy@1.5.0-classic.0
RUN npm install @npm/npme-usage-cli@1.1.2 -g
RUN apk update
RUN apk add curl
RUN apk add bash
RUN apk add python
RUN apk add make
RUN apk add g++
RUN npm install node-gyp -g
RUN apk del python
RUN apk del make
RUN apk del g++
RUN rm -rf /var/cache/apk/*

ENV PORT 5000
EXPOSE 8080

CMD ["/etc/npme/start.sh"]
