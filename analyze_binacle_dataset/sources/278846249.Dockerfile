FROM debian:stretch

ARG KIBANA_VERSION=5.2.0



RUN export DEBIAN_FRONTEND='noninteractive' &&\
    apt-get update && \
    apt-get install -y curl procps && \
    rm -rf /var/cache/apk/* && \
    curl -Sls "https://artifacts.elastic.co/downloads/kibana/kibana-$KIBANA_VERSION-linux-x86_64.tar.gz" | tar -xzf - -C /opt && \
    mv "/opt/kibana-$KIBANA_VERSION-linux-x86_64" /opt/kibana




WORKDIR /opt/kibana
COPY docker-entrypoint.sh /usr/bin

ENTRYPOINT ["docker-entrypoint.sh"]


CMD ["bin/kibana"]
