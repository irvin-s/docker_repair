FROM alpine
MAINTAINER Ian Bytchek

COPY . /docker
RUN /docker/script/build.sh