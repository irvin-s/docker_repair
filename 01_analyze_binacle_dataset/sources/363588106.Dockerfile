FROM alpine:3.4

# psql
RUN set -x \
      && apk add --update bash jq curl postgresql py-pip python-dev alpine-sdk linux-headers \
      && rm -rf /var/cache/apk/*
RUN pip install wal-e==0.9.2 awscli envdir --upgrade

# etcdctl
RUN curl -L https://github.com/coreos/etcd/releases/download/v2.3.7/etcd-v2.3.7-linux-amd64.tar.gz -o /tmp/etcd-v2.3.7-linux-amd64.tar.gz \
      && tar xzvf /tmp/etcd-v2.3.7-linux-amd64.tar.gz -C /tmp \
      && mv /tmp/etcd-v2.3.7-linux-amd64/etcdctl /usr/local/bin \
      && rm -rf /tmp/etcd*

COPY ./scripts/  /scripts

CMD ["/bin/true"]
