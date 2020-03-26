FROM node:6.2.1-wheezy
MAINTAINER Sunghoon Kang <me@devholic.io>

ENV GONI_MYSQL_HOST=mysql \
  GONI_MYSQL_PORT=3306 \
  GONI_MYSQL_USER=goni \
  GONI_MYSQL_PASS=goni \
  GONI_INFLUX_HOST=influx \
  GONI_INFLUX_PORT=8086 \
  GONI_INFLUX_USER=goni \
  GONI_INFLUX_PASS=goni \
  GONI_SLACK_CLIENT=CLIENTKEY \
  GONI_SLACK_SECRET=SECRETKEY

RUN git clone https://github.com/monitflux/goni-dashboard && \
  cd goni-dashboard && npm i && npm run build

WORKDIR "/goni-dashboard"

CMD ["node", "./build/dist/index.js"]
