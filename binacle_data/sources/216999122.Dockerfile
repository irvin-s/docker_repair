FROM ubuntu:16.04

ENV GOSU_VERSION 1.9

RUN groupadd -r hc && useradd -r -m -g hc hc

# Install deps
RUN buildDeps='gcc libxml2-dev python3-setuptools python3-pip libpq-dev libxslt1-dev git libpcre3-dev libmysqlclient-dev' \
    && set -x && apt-get -qq update \
    && apt-get install -y python3 python3-dev libxml2 libxslt1.1 libmysqlclient20 libpq5 curl $buildDeps --no-install-recommends \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && git clone https://github.com/healthchecks/healthchecks.git /src \
    && cd /src && pip3 install --no-cache-dir -r requirements.txt \
    && pip3 install --no-cache-dir uwsgi braintree mysqlclient psycopg2 \
    && apt-get purge -y --auto-remove $buildDeps \
    && apt-get clean \
    && rm -fr /var/lib/apt/lists/*

# install gosu
RUN set -x \
    && curl -o /usr/local/bin/gosu -LSs "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -LSs "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true 

RUN set -x \
    && rm -fr /src/.git \
    && chown -R hc:hc /src


WORKDIR /src

COPY local_settings.py /src/hc
COPY docker-entrypoint.sh /entrypoint.sh
COPY start.sh /start.sh

EXPOSE 9090

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/start.sh" ]
