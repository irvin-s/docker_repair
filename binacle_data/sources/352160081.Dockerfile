FROM alpine:3.4

RUN apk --no-cache add python3
RUN apk --no-cache add redis
RUN python3 -m ensurepip && pip3 install --upgrade pip setuptools rq

ADD ./rq-worker-entrypoint.sh /usr/bin/rq-worker-entrypoint.sh
RUN chmod +x /usr/bin/rq-worker-entrypoint.sh
ENTRYPOINT ["/usr/bin/rq-worker-entrypoint.sh"]
