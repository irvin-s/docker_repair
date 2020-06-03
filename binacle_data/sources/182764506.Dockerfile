# The only assumption we make about this FROM is that it has a JRE in path
FROM adoptopenjdk/openjdk11:jre-11.0.3_7@sha256:d0704102dd659b462c5255bc69f6d341caf80e887d89d4204949dd6710c3b29a

ENV KAFKA_VERSION=2.2.1 SCALA_VERSION=2.12

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='netcat-openbsd'; \
  buildDeps='curl ca-certificates gnupg dirmngr'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  curl -s   -o KEYS https://www.apache.org/dist/kafka/KEYS; \
  gpg --import KEYS && rm KEYS; \
  \
  SCALA_BINARY_VERSION=$(echo $SCALA_VERSION | cut -f 1-2 -d '.'); \
  mkdir -p /opt/kafka; \
  curl -s   -o kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc https://www.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc; \
  curl -SLs -o kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz "https://www-eu.apache.org/dist/kafka/$KAFKA_VERSION/kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz"; \
  gpg --verify kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz.asc kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz; \
  tar xzf kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz --strip-components=1 -C /opt/kafka; \
  rm kafka_$SCALA_BINARY_VERSION-$KAFKA_VERSION.tgz; \
  \
  rm -rf /opt/kafka/site-docs; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /etc/ssl/certs /root/.gnupg

WORKDIR /opt/kafka

COPY docker-help.sh /usr/local/bin/docker-help
ENTRYPOINT ["docker-help"]
