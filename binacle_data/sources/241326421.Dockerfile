# flyway v4.0
#
# docker run --rm -v $(pwd)/conf:/flyway/conf supinf/flyway:4.0 info
# docker run --rm -v $(pwd)/conf:/flyway/conf -v $(pwd)/migrations:/flyway/sql supinf/flyway:4.0 migrate

FROM java:openjdk-8-jre-alpine

ENV FLYWAY_VERSION=4.0.3

RUN apk --no-cache add bash
RUN apk --no-cache add --virtual build-deps curl \

    # Download tar.gz
    && repo="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline" \
    && curl --location --silent --show-error --out /flyway.tar.gz \
        ${repo}/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
    && tar xzf /flyway.tar.gz \
    && mv /flyway-${FLYWAY_VERSION} /flyway \
    && ln -s /flyway/flyway /usr/bin/flyway \

    # Clean up
    && rm -rf /flyway.tar.gz \
    && apk del --purge -r build-deps

WORKDIR /flyway

ENTRYPOINT ["flyway"]
CMD ["-v"]
