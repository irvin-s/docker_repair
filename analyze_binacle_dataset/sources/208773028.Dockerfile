FROM alpine

RUN apk --update add wget ca-certificates && rm -rf /var/cache/apk/*

RUN wget https://github.com/lair-framework/drone-nmap/releases/download/v2.1.1/drone-nmap_linux_amd64 \
    && mv drone-nmap_linux_amd64 /usr/bin/drone-nmap \
    && chmod +x /usr/bin/drone-nmap

ENTRYPOINT ["/usr/bin/drone-nmap"]

CMD ["-h"]
