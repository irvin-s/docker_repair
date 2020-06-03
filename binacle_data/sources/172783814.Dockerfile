FROM ubuntu:16.04 as builder

RUN apt-get update && apt-get install -qy zip

WORKDIR /tmp

ENV PGWEB_VERSION 0.9.8

ADD https://github.com/sosedoff/pgweb/releases/download/v$PGWEB_VERSION/pgweb_linux_amd64.zip /tmp
RUN unzip pgweb_linux_amd64.zip

FROM onjin/alpine-postgres:9.6
COPY --from=builder /tmp/pgweb_linux_amd64 /usr/bin/pgweb
RUN apk add --update python py-pip
RUN pip install postdoc

ADD https://raw.githubusercontent.com/catherinedevlin/opensourceshakespeare/master/shakespeare.sql /app/
COPY run.sh /app/

ENV DATABASE_URL postgres://postgres:postgres@postgres:5432/?sslmode=disable

ENTRYPOINT /app/run.sh
EXPOSE 80
