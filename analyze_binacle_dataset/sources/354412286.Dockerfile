FROM alpine:3.4

RUN apk --update add mysql-client git curl bash coreutils tar openjdk8-jre-base

WORKDIR /migrations

RUN git clone https://github.com/advancedtelematic/rvi_sota_server.git

RUN \
  mkdir flyway && \
  curl -o flyway.tgz https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0.3/flyway-commandline-4.0.3.tar.gz

RUN echo "a9819bd1fddf4ef96885665d67b0248ba9b74bd4 flyway.tgz" | sha1sum -c -

RUN tar zxvf flyway.tgz -C flyway --strip-components=1

ADD entrypoint.sh /migrations/entrypoint.sh

ADD wait_for_mysql.sh wait_for_mysql.sh

ENTRYPOINT /migrations/entrypoint.sh
