FROM alpine:3.3
MAINTAINER zwh8800 <496781108@qq.com>

WORKDIR /app

RUN apk update && apk add ca-certificates && \
    apk add tzdata && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone

ADD ./cloudxns-ddns /app

VOLUME /app/log
VOLUME /app/config

CMD ["./cloudxns-ddns", "-log_dir", "log", "-config", "config/cloudxns-ddns.gcfg"]
