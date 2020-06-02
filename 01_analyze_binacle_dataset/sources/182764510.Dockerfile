FROM solsson/kafka-jre:8@sha256:1ebc3c27c30f5925d240aaa0858e111c2fa6d358048b0f488860ea9cd9c84822 \
  as build

ENV KAFKA_MANAGER_VERSION=2.0.0.2
ENV KAFKA_MANAGER_ARCHIVE=https://github.com/yahoo/kafka-manager/archive/${KAFKA_MANAGER_VERSION}.tar.gz

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps=''; \
  buildDeps='curl ca-certificates unzip apt-transport-https gnupg2 lsb-release'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -; \
  echo "deb https://deb.nodesource.com/node_8.x stretch main" > /etc/apt/sources.list.d/nodesource.list; \
  apt-get update && apt install -y --no-install-recommends nodejs; \
  \
  mkdir -p /opt/kafka-manager-src; \
  curl -SLs "${KAFKA_MANAGER_ARCHIVE}" | tar -xzf - --strip-components=1 -C /opt/kafka-manager-src; \
  \
  cd /opt/kafka-manager-src; \
  ./sbt clean dist; \
  \
  cd /opt; \
  unzip kafka-manager-src/target/universal/kafka-manager-$KAFKA_MANAGER_VERSION.zip; \
  mv kafka-manager-$KAFKA_MANAGER_VERSION kafka-manager; \
  \
  rm -rf /root/.sbt /root/.ivy2 /opt/kafka-manager-src; \
  \
  apt-get purge -y --auto-remove $buildDeps nodejs; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt

FROM solsson/jdk-opensource:11.0.2@sha256:9088fd8eff0920f6012e422cdcb67a590b2a6edbeae1ff0ca8e213e0d4260cf8

COPY --from=build /opt/kafka-manager /opt/kafka-manager

WORKDIR /opt/kafka-manager

ENTRYPOINT ["./bin/kafka-manager"]
