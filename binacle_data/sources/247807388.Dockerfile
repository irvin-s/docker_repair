FROM alpine:3.9
LABEL maintainer "gavin zhou <gavin.zhou@gmail.com>"

ENV GRAFANA_VERSION=6.2.2

RUN set -ex \
 && addgroup -S grafana \
 && adduser -S -G grafana grafana \
 && apk add --no-cache libc6-compat ca-certificates su-exec \
 && mkdir /tmp/setup \
 && wget -P /tmp/setup http://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz \
 && tar -xzf /tmp/setup/grafana-$GRAFANA_VERSION.linux-amd64.tar.gz -C /tmp/setup --strip-components=1 \
 && install -m 755 /tmp/setup/bin/grafana-server /usr/local/bin/ \
 && install -m 755 /tmp/setup/bin/grafana-cli /usr/local/bin/ \
 && mkdir -p /grafana/datasources /grafana/dashboards /grafana/data /grafana/logs /grafana/plugins /var/lib/grafana \
 && cp -r /tmp/setup/public /grafana/public \
 && chown -R grafana:grafana /grafana \
 && ln -s /grafana/plugins /var/lib/grafana/plugins \
 && grafana-cli plugins update-all \
 && rm -rf /tmp/setup

VOLUME /grafana/data

COPY ./config.docker/defaults.ini /grafana/conf/
COPY ./run.sh /run.sh

EXPOSE 3000

CMD ["/run.sh"]
