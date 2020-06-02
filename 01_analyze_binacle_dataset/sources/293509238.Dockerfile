FROM concourse/buildroot:git

RUN cat /etc/ssl/certs/*.pem > /etc/ssl/certs/ca-certificates.crt

ENV jq_version=1.6
ADD https://github.com/stedolan/jq/releases/download/jq-${jq_version}/jq-linux64 /usr/local/bin/jq
RUN chmod +x /usr/local/bin/jq

ENV alertmanager_version=0.16.0
ADD https://github.com/prometheus/alertmanager/releases/download/v${alertmanager_version}/alertmanager-${alertmanager_version}.linux-amd64.tar.gz /tmp/alertmanager-${alertmanager_version}.linux-amd64.tar.gz
RUN tar xzvf /tmp/alertmanager-${alertmanager_version}.linux-amd64.tar.gz -C /tmp alertmanager-${alertmanager_version}.linux-amd64/amtool && \
    mv /tmp/alertmanager-${alertmanager_version}.linux-amd64/amtool /usr/local/bin/amtool && \
    chmod +x /usr/local/bin/amtool && \
    rm -fr /tmp/alertmanager-*

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*
