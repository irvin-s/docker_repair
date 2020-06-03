FROM rabbitmq:3.6.6-management

COPY cluster-status.sh /usr/local/bin/
COPY apply-cluster-config.sh /usr/local/bin/
COPY cluster.config /etc/rabbitmq/

COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config

ENV RABBITMQ_CLUSTERER_VERSION 1.0.3

ENV RABBITMQ_CLUSTERER_URL "https://github.com/rabbitmq/rabbitmq-clusterer/releases/download/v${RABBITMQ_CLUSTERER_VERSION}/rabbitmq_clusterer-${RABBITMQ_CLUSTERER_VERSION}.ez"

ENV RABBITMQ_BOOT_MODULE rabbit_clusterer

ENV RABBITMQ_SERVER_ADDITIONAL_ERL_ARGS "-pa /plugins/rabbitmq_clusterer.ez/rabbitmq_clusterer-${RABBITMQ_CLUSTERER_VERSION}/ebin"

RUN apt-get update && \
    apt-get install -y --no-install-recommends vim telnet ca-certificates wget && \
    rm -rf /var/lib/apt/lists/* && \
    wget -O /plugins/rabbitmq_clusterer.ez $RABBITMQ_CLUSTERER_URL && \
    rabbitmq-plugins enable rabbitmq_clusterer --offline && \
    apt-get purge -y --auto-remove ca-certificates wget



