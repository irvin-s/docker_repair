FROM alpine

RUN apk --update add wget ca-certificates && rm -rf /var/cache/apk/*

RUN wget https://github.com/lair-framework/drone-nessus/releases/download/v2.2.1/drone-nessus_linux_amd64 \
    && mv drone-nessus_linux_amd64 /usr/bin/drone-nessus \
    && chmod +x /usr/bin/drone-nessus

ENTRYPOINT ["/usr/bin/drone-nessus"]

CMD ["-h"]
