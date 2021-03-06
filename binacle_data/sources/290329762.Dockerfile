# This Dockerfile is used when running locally using docker-compose for Acceptance Testing.

FROM azul/zulu-openjdk:12.0.1

LABEL maintainer="dev@redotter.sg"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    netcat \
    socat \
    curl \
 && rm -rf /var/lib/apt/lists/*

COPY script/start.sh /start.sh
COPY script/wait.sh /wait.sh

# test.yaml is copied as config.yaml for AT.
COPY config/prime-service-account.json /secret/prime-service-account.json
COPY config/testDb.csv /config-data/imeiDb.csv
COPY config/customer.graphqls /config/customer.graphqls
COPY config/test.yaml /config/config.yaml
COPY config/test_keyset_pub_cltxt /config/test_keyset_pub_cltxt_global
COPY config/test_keyset_pub_cltxt /config/test_keyset_pub_cltxt_sg

COPY build/libs/prime-uber.jar /prime.jar

EXPOSE 7687
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

CMD ["/start.sh"]