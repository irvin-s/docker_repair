# Copyright (c) 2019- Andy Hayden
# https://github.com/hayd/deno_docker

FROM frolvlad/alpine-glibc:alpine-3.9

ENV DENO_VERSION=0.5.0

RUN apk add --no-cache curl && \
  curl -fsSL https://github.com/denoland/deno/releases/download/v${DENO_VERSION}/deno_linux_x64.gz --output deno.gz && \
  gunzip deno.gz && \
  chmod 777 deno && \
  mv deno /bin/deno && \
  apk del curl

COPY app.ts /app/
COPY src /app/src

WORKDIR /app

RUN deno fetch app.ts

COPY . /app

CMD deno run --allow-net --allow-read app.ts -p $PORT