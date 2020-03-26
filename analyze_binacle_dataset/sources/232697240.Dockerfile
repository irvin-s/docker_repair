FROM alpine:3.4

RUN apk add --no-cache git build-base \
                       jansson jansson-dev \
                       libmicrohttpd libmicrohttpd-dev \
                       openssl-dev &&\
    git clone https://github.com/github/brubeck.git &&\
    brubeck/script/bootstrap &&\
    mv brubeck/brubeck /usr/local/bin/ && rm -r /brubeck &&\
    apk del git build-base jansson-dev libmicrohttpd-dev openssl-dev

ADD run.sh /

ENTRYPOINT ["/run.sh"]
