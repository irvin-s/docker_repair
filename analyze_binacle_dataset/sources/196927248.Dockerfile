FROM postgres

RUN apt-get update -y && apt-get install -y \
    curl

ENV FLYWAY_ARCHIVE_URL  https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0.3/flyway-commandline-4.0.3-linux-x64.tar.gz
ENV FLYWAY_DIST_DIR     /flyway
ENV PATH                ${PATH}:${FLYWAY_DIST_DIR}

RUN mkdir ${FLYWAY_DIST_DIR} &&\
    curl -L ${FLYWAY_ARCHIVE_URL} | tar xz -C ${FLYWAY_DIST_DIR} --strip-components=1

WORKDIR /db
