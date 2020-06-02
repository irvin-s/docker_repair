# Set the base image to Ubuntu
FROM mhart/alpine-node:0.10.42

# File Author / Maintainer
MAINTAINER Ben Coe

COPY ./replicated/registry-service/start.sh /etc/npme/start.sh
WORKDIR /etc/npme

RUN echo '@npm:registry=https://enterprise.npmjs.com/' > ~/.npmrc
RUN npm install @npm/registry-relational-service@1.3.0
COPY ./replicated/registry-service/config-development.js /etc/npme/node_modules/@npm/registry-relational-service/config-development.js

EXPOSE 5005

CMD ["/etc/npme/start.sh"]
