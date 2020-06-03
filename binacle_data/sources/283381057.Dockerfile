FROM alpine:latest

LABEL maintainer="beginor <beginor@qq.com>"

RUN apk add --no-cache --update busybox-extras aria2

COPY ["aria2.conf", "httpd.conf", "entry-point.sh", "/aria2/"]

EXPOSE 6800 6880

VOLUME ["/aria2/downloads", "/aria2/webui"]

ENTRYPOINT ["/aria2/entry-point.sh"]
