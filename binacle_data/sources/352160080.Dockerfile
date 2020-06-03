FROM alpine:3.4

RUN apk --no-cache add python3
RUN apk --no-cache add redis
RUN python3 -m ensurepip && pip3 install --upgrade pip setuptools rq
EXPOSE 6379
ENTRYPOINT ["/usr/bin/redis-server","--protected-mode","no"]
