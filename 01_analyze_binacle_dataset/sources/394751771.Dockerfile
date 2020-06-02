FROM alpine:latest
MAINTAINER weidewang dewang.wei@gmail.com

ENV  TZ="Asia/Shanghai"
RUN apk add --update --no-cache ca-certificates tzdata curl

COPY objs/reverse /opt/reverse
WORKDIR /opt/
EXPOSE 6000
ENTRYPOINT ["/opt/reverse"]
