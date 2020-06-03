FROM       node:0.12.2-slim
MAINTAINER Charlie Revett <charlierevett@gmail.com>

COPY . /app

RUN cd /app; npm install

CMD ["node", "/app/bin/watchtower", "/app/config.yaml"]
