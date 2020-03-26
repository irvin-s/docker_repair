FROM python:2.7.13-alpine3.6

ENV ETCDCTL_VERSION v3.2.5

RUN apk add --no-cache --update \
    bash \
    gettext \
    curl \
    openssl \
    libffi \
    openssh-client \

    # Etcdctl
    && curl -L https://github.com/coreos/etcd/releases/download/$ETCDCTL_VERSION/etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz -o /tmp/etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz \
    && cd /tmp && gzip -dc etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz | tar -xof -  \
    && cp -f /tmp/etcd-$ETCDCTL_VERSION-linux-amd64/etcdctl /usr/local/bin \

    # Cleanup
    && rm -rf /tmp/*

ADD requirements.txt /opt/yoda-test/requirements.txt
RUN apk add --no-cache --update --virtual build-dependencies \
      musl-dev \
      linux-headers \
      build-base \
      pcre-dev \
      libffi-dev \
      openssl-dev \

    # Python dependencies
    && pip install --ignore-installed  --no-cache-dir \
      -r /opt/yoda-test/requirements.txt \

    # Cleanup
    && apk del build-dependencies \
    && find /usr/local \
        \( -type d -a -name test -o -name tests \) -exec echo rm -rf '{}' + \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) -exec echo rm -f '{}' +

ADD . /opt/yoda-test
WORKDIR /opt/yoda-test

CMD ["nosetests"]