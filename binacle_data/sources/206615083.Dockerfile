FROM shipito/nodejs:6-alpine
MAINTAINER Patrik Votocek <patrik@votocek.cz>

RUN apk --update --no-cache add python && \
    npm install -g -q git://github.com/markatom/api-blueprint-validator.git#markatom
