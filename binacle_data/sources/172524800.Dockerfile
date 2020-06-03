# Set the base image to Ubuntu
FROM mhart/alpine-node:4.4.2

# File Author / Maintainer
MAINTAINER Ben Coe

COPY ./replicated/validate-and-store/start.sh /etc/npme/start.sh
WORKDIR /etc/npme

RUN echo '@npm:registry=https://enterprise.npmjs.com/' > ~/.npmrc
RUN npm install @npm/validate-and-store

CMD ["/etc/npme/start.sh"]
