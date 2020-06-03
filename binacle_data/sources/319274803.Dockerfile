FROM openjdk:8-jre-slim

RUN set -ex; \
    apt-get update && \
    apt-get install -y --no-install-recommends wget=1.18-5+deb9u2 runit=2.1.2-9.2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd --home-dir /home/magnet --create-home --shell /bin/bash --user-group magnet

WORKDIR /home/magnet

ADD https://s3-eu-west-1.amazonaws.com/cat-or-dog-cortex-nippy/trained-network.nippy /home/magnet/trained-network.nippy

ENV CORTEX_TRAINED_NN_FILE /home/magnet/trained-network.nippy

COPY target/aluminium-standalone.jar aluminium-standalone.jar

COPY run-as-user.sh /usr/local/bin/

CMD ["/usr/local/bin/run-as-user.sh", "java", "-jar", "aluminium-standalone.jar", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-server", ":duct/migrator", ":duct/daemon"]

EXPOSE 3000
