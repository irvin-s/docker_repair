FROM keymetrics/pm2-docker-alpine:6

MAINTAINER leopku "https://twitter.com/leopku"

ARG NPM_REGISTRY=https://registry.npmjs.org

ENV PARSE_SERVER_DATABASE_URI=mongodb://mongo/revel

RUN npm install --registry=${NPM_REGISTRY} -g parse-server parse-dashboard

ADD ./process.sample.yml /app/process.yml
ADD ./parse-server.sample.json /app/parse-server.json
ADD ./parse-dashboard.sample.json /app/parse-dashboard.json
ADD ./cloud /app/cloud

VOLUME ["/app"]

EXPOSE 1337 4040 43554

WORKDIR /app

CMD ["pm2-docker", "start", "--auto-exit", "--env", "production", "process.yml"]
