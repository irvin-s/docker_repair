#
# Dockerfile for grafana-arm
#

FROM resin/rpi-raspbian:stretch
MAINTAINER EasyPi Software Foundation

ENV GRAFANA_VERSION=5.2.4
ENV GRAFANA_FILE=grafana_${GRAFANA_VERSION}_armhf.deb
ENV GRAFANA_URL=https://s3-us-west-2.amazonaws.com/grafana-releases/release/${GRAFANA_FILE}

RUN set -xe \
    && apt-get update \
    && apt-get install -y ca-certificates \
                          libfontconfig \
                          wget \
    && wget ${GRAFANA_URL} \
    && dpkg -i ${GRAFANA_FILE} \
    && apt-get purge --auto-remove -y wget \
    && rm -rf ${GRAFANA_FILE} \
              /var/lib/apt/lists/*

ENV GF_PATHS_DATA=/var/lib/grafana
ENV GF_PATHS_LOGS=/var/log/grafana
ENV GF_PATHS_PLUGINS=/var/lib/grafana/plugins

VOLUME /etc/grafana \
       $GF_PATHS_DATA \
       $GF_PATHS_LOGS

EXPOSE 3000

CMD grafana-server --homepath=/usr/share/grafana \
                   --config=/etc/grafana/grafana.ini \
                   cfg:default.paths.data="$GF_PATHS_DATA" \
                   cfg:default.paths.logs="$GF_PATHS_LOGS" \
                   cfg:default.paths.plugins="$GF_PATHS_PLUGINS"
