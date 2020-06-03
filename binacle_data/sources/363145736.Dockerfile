FROM node:6.3.1

RUN npm install -g bower gulp-cli

WORKDIR /app

COPY entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

RUN adduser frontend
USER frontend
