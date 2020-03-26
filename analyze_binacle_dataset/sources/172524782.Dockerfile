# Set the base image to Ubuntu
FROM mhart/alpine-node:6.10.2

# File Author / Maintainer
MAINTAINER Ben Coe

COPY ./replicated/policy-follower/start.sh /etc/npme/start.sh
COPY ./replicated/policy-follower/add-package.sh /etc/npme/add-package.sh
COPY ./replicated/policy-follower/remove-package.sh /etc/npme/remove-package.sh
COPY ./replicated/policy-follower/reset-follower.sh /etc/npme/reset-follower.sh
WORKDIR /etc/npme

RUN echo '@npm:registry=https://enterprise.npmjs.com/' > ~/.npmrc
RUN npm install @npm/policy-follower@1.2.4
RUN npm install @npm/package-whitelist@0.1.5
RUN apk update
RUN apk add curl
RUN rm -rf /var/cache/apk/*

CMD ["/etc/npme/start.sh"]
