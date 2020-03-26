FROM debian:jessie
MAINTAINER Nathan Kot <me@nathankot.com>
ENV LANG            C.UTF-8

RUN apt-get update && \
    apt-get install -y \
      libpq-dev \
      python-dev \
      libsqlite3-dev \
      ca-certificates \
      build-essential

EXPOSE 80

ENV PORT 80

COPY entrypoint.sh /
COPY wait-for-it.sh /

# Run it
WORKDIR /opt/server
COPY dist /opt/server/dist
COPY migrations /opt/server/migrations

ENTRYPOINT ["/entrypoint.sh", "--"]

CMD mkdir -p /var/log/server && \
    /opt/server/dist/x86_64-linux/server 2>&1 | tee /var/log/server/server.log
