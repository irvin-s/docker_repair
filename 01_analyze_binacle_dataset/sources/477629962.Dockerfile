FROM node:6.3.0-wheezy

WORKDIR /app
ADD ./package.json /app/
RUN npm install --production
ADD ./docker /usr/local/bin/docker
ADD public /app/public
ADD dist/index.js /app/dist/index.js
ENV PRODUCTION true
CMD node dist/index.js
