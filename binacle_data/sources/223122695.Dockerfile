FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

# NOTE(elemoine): the InfluxDB package is downloaded from dl.influxdb.com. Do
# we want to host the package instead?

RUN gpg \
        --keyserver hkp://ha.pool.sks-keyservers.net \
        --recv-keys 05CE15085FC09D18E99EFB22684A14CF2582E0C5 \
    && curl https://dl.influxdata.com/influxdb/releases/influxdb_{{ influxdb_version }}_amd64.deb.asc -o /tmp/influxdb.deb.asc \
    && curl https://dl.influxdata.com/influxdb/releases/influxdb_{{ influxdb_version }}_amd64.deb -o /tmp/influxdb.deb \
    && gpg --batch --verify /tmp/influxdb.deb.asc /tmp/influxdb.deb \
    && dpkg -i /tmp/influxdb.deb \
    && chown -R influxdb: /etc/influxdb \
    && usermod -a -G microservices influxdb \
    && rm -f /tmp/influxdb.deb.asc /tmp/influxdb.deb

USER influxdb
