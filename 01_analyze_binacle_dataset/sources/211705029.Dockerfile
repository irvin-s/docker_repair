FROM openjdk:8-alpine

ARG SCALA_VERSION
ARG SCALA_HOME

ENV SCALA_VERSION=${SCALA_VERSION:-2.11.8} \
    SCALA_HOME=${SCALA_HOME:-/usr/scala}

# NOTE: bash is used by scala/scalac scripts, and it cannot be easily replaced with ash.
RUN apk add --no-cache --virtual=build-dependencies wget ca-certificates \
    && apk add --no-cache bash \
    && cd "/tmp" \
    && wget -O - "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" | tar xzf - \
    && mkdir "${SCALA_HOME}" \
    && rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat \
    && mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" \
    && ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" \
    && apk del build-dependencies \
    && rm -rf "/tmp/"*

ENTRYPOINT ["scala"]
CMD ["-help"]