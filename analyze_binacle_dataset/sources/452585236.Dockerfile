## development #################################################################

FROM golang:1.12 AS development

RUN apt-get update && apt-get -y install curl software-properties-common && curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get -y install nodejs

RUN curl -Ls https://github.com/mattgreen/watchexec/releases/download/1.8.6/watchexec-1.8.6-x86_64-unknown-linux-gnu.tar.gz | \
    tar -C /usr/bin --strip-components 1 -xz

ENV DEVELOPMENT=true

WORKDIR /go/src/github.com/convox/site/webpack
COPY webpack/node_modules ./node_modules
RUN npm rebuild

WORKDIR /go/src/github.com/convox/site
COPY . .
RUN make build

CMD ["bin/web"]

## package #####################################################################

FROM golang:1.12 AS package

RUN apt-get update && apt-get -y install curl software-properties-common && curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get -y install nodejs

RUN go get -u github.com/gobuffalo/packr/packr

ENV PACKAGE=true

WORKDIR /go/src/github.com/convox/site

COPY --from=development /go/src/github.com/convox/site .
RUN make -B build

## production ##################################################################

FROM ubuntu:18.04 AS production

ENV DEVELOPMENT=false

WORKDIR /

COPY --from=package /go/bin/web /usr/local/bin/web

RUN groupadd -r site && useradd -r -g site site
USER site

CMD ["/usr/local/bin/web"]
