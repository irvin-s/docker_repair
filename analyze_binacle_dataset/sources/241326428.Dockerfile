# flyway v5.2
#
# docker run --rm -v $(pwd)/conf:/flyway/conf supinf/flyway:5.2 info
# docker run --rm -v $(pwd)/conf:/flyway/conf -v $(pwd)/migrations:/flyway/sql supinf/flyway:5.2 migrate
# docker run --rm -v $(pwd)/conf:/flyway/conf -v $(pwd)/migrations:/flyway/sql -e FLYWAY_JAVA_OPTS="-Xms512m -Xmx2048m" supinf/flyway:5.2 migrate

FROM java:openjdk-8-jre-alpine

ENV FLYWAY_VERSION=5.2.4

ADD flyway /usr/bin/

RUN apk --no-cache add bash
RUN apk --no-cache add --virtual build-deps curl \
    && chmod +x /usr/bin/flyway \
    && repo="https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline" \
    && curl --location --silent --show-error --out /flyway.tar.gz \
        ${repo}/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz \
    && sha1="c4b5f7ae3ec41221f78a126b0a1637942484fa3f" \
    && echo "$sha1  flyway.tar.gz" | sha1sum -c - \
    && tar xzf /flyway.tar.gz \
    && mv /flyway-${FLYWAY_VERSION} /flyway \
    && rm -rf /flyway.tar.gz \
              /flyway/lib/enterprise \
              /flyway/lib/pro \
              /flyway/jre \
    && apk del --purge -r build-deps

WORKDIR /flyway

ENTRYPOINT ["flyway"]
CMD ["-v"]
