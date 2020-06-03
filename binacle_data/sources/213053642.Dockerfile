FROM debian:stretch
MAINTAINER Angel Cezon <angel@autorizado.net>

RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y mldonkey-server && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/log/mldonkey && \
    rm /var/lib/mldonkey/*

ENV MLDONKEY_DIR /var/lib/mldonkey

VOLUME ["/var/lib/mldonkey", "/mnt/mldonkey_tmp", \
        "/mnt/mldonkey_completed"]

EXPOSE 4000 4080 20562 20566/udp 6209 6209/udp 16965/udp 3617/udp 6881 6882

COPY start.sh /start.sh
RUN chmod -v +x /start.sh
CMD /start.sh
