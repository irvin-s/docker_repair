FROM alpine

RUN apk --update add wget ca-certificates && rm -rf /var/cache/apk/*

RUN wget https://github.com/lair-framework/drone-burp/releases/download/v1.0.1/drone-burp_linux_amd64 \
    && mv drone-burp_linux_amd64 /usr/bin/drone-burp \
    && chmod +x /usr/bin/drone-burp

ENTRYPOINT ["/usr/bin/drone-burp"]

CMD ["-h"]
