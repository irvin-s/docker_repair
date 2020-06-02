FROM praseodym/arm32v7-debian-oracle-java:jessie

ARG suite=stable
RUN export DEBIAN_FRONTEND='noninteractive' && \
    echo "deb http://www.ubnt.com/downloads/unifi/debian $suite ubiquiti" > /etc/apt/sources.list.d/unifi.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-get update && \
    apt-get install -y --no-install-recommends unifi mongodb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 6789/tcp 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp
VOLUME /usr/lib/unifi/data /usr/lib/unifi/run
ENV JAVA_OPTS -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+ExitOnOutOfMemoryError -XshowSettings:vm
COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
