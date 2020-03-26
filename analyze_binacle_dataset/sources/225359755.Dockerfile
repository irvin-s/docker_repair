FROM elasticsearch:2.3.5
MAINTAINER PubNative Team <team@pubnative.net>

RUN /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head \
 && /usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf
