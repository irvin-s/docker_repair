FROM influxdb:1.0-alpine
MAINTAINER PubNative Team <team@pubnative.net>

COPY influxdb.conf.toml /etc/influxdb/influxdb.conf
