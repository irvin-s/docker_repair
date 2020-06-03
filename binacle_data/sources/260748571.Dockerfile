# Dockerizing thunder xware
# xware version: Xware1.0.31 release date: 2014-08-27

FROM i386/debian:wheezy-slim
LABEL maintainer="Senorsen <senorsen.zhang@gmail.com>"
WORKDIR /app

ENV LANG C.UTF-8
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y procps libz1 libncurses5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /app/bin

COPY thunder start.sh ./
RUN chmod +x start.sh

VOLUME /app/TDDOWNLOAD
VOLUME /app/bin/cfg

CMD ["./start.sh"]

