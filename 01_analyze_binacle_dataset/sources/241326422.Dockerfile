# flyway v4.1
#
# docker run --rm -v $(pwd)/conf:/flyway/conf supinf/flyway:4.1 info
# docker run --rm -v $(pwd)/conf:/flyway/conf -v $(pwd)/migrations:/flyway/sql supinf/flyway:4.1 migrate
# docker run --rm -v $(pwd)/conf:/flyway/conf -v $(pwd)/migrations:/flyway/sql -e FLYWAY_JAVA_OPTS="-Xms512m -Xmx2048m" supinf/flyway:4.1 migrate

FROM java:openjdk-8-jre-alpine

ENV FLYWAY_VERSION=4.1.2

ADD flyway /usr/bin/

RUN apk --no-cache add bash
RUN apk --no-cache add --virtual build-deps curl \
    && chmod +x /usr/bin/flyway \

    # Download tar.gz
    && repo="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline" \
    && curl --location --silent --show-error --out /flyway.tar.gz \
        ${repo}/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}.tar.gz \
    && sha1="93b38bf66d13b80531ea1cc37d46c4839e862073" \
    && echo "$sha1  flyway.tar.gz" | sha1sum -c - \
    && tar xzf /flyway.tar.gz \
    && mv /flyway-${FLYWAY_VERSION} /flyway \

    # Clean up
    && rm -rf /flyway.tar.gz \
    && apk del --purge -r build-deps

WORKDIR /flyway

ENTRYPOINT ["flyway"]
CMD ["-v"]
