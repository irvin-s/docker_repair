FROM {{ image_spec("base-tools") }}
MAINTAINER {{ maintainer }}

RUN curl https://download.elastic.co/kibana/kibana/kibana-{{ kibana_version }}-amd64.deb -o /tmp/kibana.deb \
    && dpkg -i /tmp/kibana.deb \
    && rm -f /tmp/kibana.deb

RUN usermod -a -G microservices kibana \
    && chown -R kibana: /opt/kibana

USER kibana
