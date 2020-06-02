FROM debian:jessie
MAINTAINER Sunghoon Kang <me@devholic.io>

ENV GONI_MYSQL_HOST=mysql \
  GONI_MYSQL_PORT=3306 \
  GONI_MYSQL_USER=goni \
  GONI_MYSQL_PASS=goni \
  GONI_INFLUX_HOST="http://influx:8086" \
  GONI_INFLUX_USER=goni \
  GONI_INFLUX_PASS=goni

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*
RUN wget -O - https://github.com/monitflux/goniplus-worker/releases/download/v0.1-beta5/goniplus-worker-v0.1-beta5-linux-x86_64.tar.gz | tar zxf -

CMD ["./goniplus-worker"]
