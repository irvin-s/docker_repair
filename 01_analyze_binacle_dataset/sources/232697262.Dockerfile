FROM alpine:3.4

RUN apk add --no-cache git bash autoconf build-base automake util-linux-dev zlib-dev libuuid
RUN git clone --depth=1 https://github.com/firehol/netdata.git &&\
    addgroup -S netdata && adduser netdata -DSH -G netdata netdata &&\
    cd netdata && ./netdata-installer.sh --dont-wait --dont-start-it &&\
    cd / && rm -r netdata &&\
    apk del git bash autoconf build-base automake util-linux-dev zlib-dev

VOLUME /etc/netdata

EXPOSE 19999

ADD run.sh /

ENTRYPOINT ["/run.sh"]

CMD ["-D"]
