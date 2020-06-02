FROM alpine:3.4

RUN apk --no-cache add python3
RUN python3 -m ensurepip && pip3 install --upgrade pip setuptools rq-dashboard

EXPOSE 9181

ADD ./rq-dashboard-entrypoint.sh /usr/bin/rq-dashboard-entrypoint.sh
RUN chmod +x /usr/bin/rq-dashboard-entrypoint.sh

ENTRYPOINT ["/usr/bin/rq-dashboard-entrypoint.sh"]
