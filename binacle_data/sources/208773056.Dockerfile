FROM alpine

RUN apk add --update bash git openssl drill && rm -rf /var/cache/apk/*

WORKDIR /root/

RUN git clone https://github.com/drwetter/testssl.sh.git

WORKDIR testssl.sh/

ENTRYPOINT ["./testssl.sh"]
