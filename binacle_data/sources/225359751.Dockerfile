FROM python:2.7
MAINTAINER PubNative Team <team@pubnative.net>

# grab gosu for easy step-down from root
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN arch="$(dpkg --print-architecture)" \
	&& set -x \
	&& curl -o /usr/local/bin/gosu -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch" \
	&& curl -o /usr/local/bin/gosu.asc -fSL "https://github.com/tianon/gosu/releases/download/1.3/gosu-$arch.asc" \
	&& gpg --verify /usr/local/bin/gosu.asc \
	&& rm /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu

ADD docker-entrypoint.sh /

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r curator && useradd -r -g curator curator \
    && pip install elasticsearch-curator==4.1.2 \
    && chown curator:curator /docker-entrypoint.sh \
    && chmod +x /docker-entrypoint.sh \
    && pip install envtpl

ADD curator.yml.tpl /etc/curator.yml.tpl
ADD actions.yml.tpl /etc/actions.yml.tpl

ENV INTERVAL_IN_HOURS=24

ENV ES_CLIENT_hosts='["elasticsearch"]'
ENV ES_CLIENT_port=9200
ENV ES_CLIENT_timeout=30

ENV ES_LOGGING_loglevel=DEBUG

ENV ES_ACTIONS_COUNT="1"
ENV ES_ACTIONS_0_action="delete_indices"
ENV ES_ACTIONS_0_options='{"ignore_empty_list":"True"}'
ENV ES_ACTIONS_0_filters='[{"filtertype": "kibana"}, {"filtertype":"age","source":"name","direction":"older","unit": "days","unit_count":30,"timestring":"%Y.%m.%d"}]'

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["curator"]
