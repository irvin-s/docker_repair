FROM openjdk:8u181-jdk-slim-stretch

ENV JAVA_HOME=/opt/java

ARG VERSION
ENV CEREBRO_VERSION=$VERSION

RUN cd /opt/ \
    && apt-get update -q \
    && apt-get install -q -y --no-install-recommends ca-certificates curl \
    && curl -Lskj https://github.com/lmenezes/cerebro/releases/download/v${CEREBRO_VERSION}/cerebro-${CEREBRO_VERSION}.tgz -o cerebro-${CEREBRO_VERSION}.tgz \
    && tar zxvf cerebro-${CEREBRO_VERSION}.tgz \
    && rm cerebro-${CEREBRO_VERSION}.tgz \
    && mkdir cerebro-${CEREBRO_VERSION}/logs \
    && mv cerebro-${CEREBRO_VERSION} cerebro \
    && mkdir -p /var/lib/cerebro/ \
    && rm -rf /tmp/* \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD application.conf /opt/cerebro/conf/
WORKDIR /opt/cerebro
EXPOSE 9000
CMD ["./bin/cerebro"]

