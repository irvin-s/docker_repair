# Apache ActiveMQ v5.15
# docker run --rm -p 1883:1883 -p 8161:8161 supinf/activemq:5.15

FROM alpine:3.8 AS build

ENV ACTIVEMQ_VERSION=5.15.8

RUN apk --no-cache add curl
RUN repo=https://archive.apache.org/dist/activemq \
    && curl --location --silent --show-error --out activemq.tar.gz \
       "${repo}/${ACTIVEMQ_VERSION}/apache-activemq-${ACTIVEMQ_VERSION}-bin.tar.gz"
RUN echo "8c9b3216a0378f6377a9ba35f23915a3a52a1c15ac7b316bc06781d6a6ba83ce775534aa0054bd1aa37fb4d285946f914dbb21a14cc485e180a0d86c834df02e  activemq.tar.gz" | sha512sum -c -
RUN tar xzf activemq.tar.gz

FROM openjdk:8-jre-alpine

ENV ACTIVEMQ_VERSION=5.15.8 \
    ACTIVEMQ_TCP=61616 \
    ACTIVEMQ_AMQP=5672 \
    ACTIVEMQ_STOMP=61613 \
    ACTIVEMQ_MQTT=1883 \
    ACTIVEMQ_WS=61614 \
    ACTIVEMQ_UI=8161 \
    ACTIVEMQ_HOME=/opt/activemq \
    PATH=/opt/activemq/bin:$PATH

COPY --from=build "/apache-activemq-${ACTIVEMQ_VERSION}/bin/activemq" "${ACTIVEMQ_HOME}/bin/activemq"
COPY --from=build "/apache-activemq-${ACTIVEMQ_VERSION}/bin/activemq.jar" "${ACTIVEMQ_HOME}/bin/activemq.jar"
COPY --from=build "/apache-activemq-${ACTIVEMQ_VERSION}/lib" "${ACTIVEMQ_HOME}/lib"
COPY --from=build "/apache-activemq-${ACTIVEMQ_VERSION}/conf" "${ACTIVEMQ_HOME}/conf"
COPY --from=build "/apache-activemq-${ACTIVEMQ_VERSION}/webapps" "${ACTIVEMQ_HOME}/webapps"

RUN addgroup -S activemq \
    && adduser -S -H -G activemq -h "${ACTIVEMQ_HOME}" activemq \
    && chown -R activemq:activemq "${ACTIVEMQ_HOME}"
USER activemq
WORKDIR $ACTIVEMQ_HOME

ENTRYPOINT ["activemq"]
CMD ["console"]
