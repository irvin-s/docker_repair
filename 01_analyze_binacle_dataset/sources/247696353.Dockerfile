# Based on: https://github.com/pointslope/docker-datomic
# This version uses environment variables for credentials
FROM clojure:lein-2.6.1-alpine

ARG DATOMIC_LOGIN
ARG DATOMIC_PASSWORD

ENV DATOMIC_VERSION 0.9.5544
ENV DATOMIC_HOME    /opt/datomic-pro-$DATOMIC_VERSION
ENV DATOMIC_DATA    /var/datomic/data
ENV DATOMIC_LOG     /var/datomic/log
ENV DATOMIC_CONFIG  /var/datomic/config

VOLUME $DATOMIC_DATA
VOLUME $DATOMIC_LOG
VOLUME $DATOMIC_CONFIG

RUN apk add --no-cache unzip curl

RUN curl -u $DATOMIC_LOGIN:$DATOMIC_PASSWORD -SL https://my.datomic.com/repo/com/datomic/datomic-pro/$DATOMIC_VERSION/datomic-pro-$DATOMIC_VERSION.zip -o /tmp/datomic.zip \
&& unzip /tmp/datomic.zip -d /opt \
&& rm -f /tmp/datomic.zip

WORKDIR $DATOMIC_HOME

ADD ./docker/images/datomic-transactor/start_transactor.sh .
CMD ./start_transactor.sh

EXPOSE 4334 4335 4336
