FROM alpine:3.8 as build

ENV HUGO_VER=0.49.2
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/hugo_${HUGO_VER}_Linux-64bit.tar.gz /srv/hugo.tar.gz
RUN cd /srv && tar -zxf hugo.tar.gz && ls -la

FROM alpine:3.8

COPY --from=build /srv/hugo /bin/hugo
COPY exec.sh /srv/exec.sh

RUN \
    chmod +x /srv/exec.sh && \
    apk add --update --no-cache tzdata curl openssl git openssh-client python3 ca-certificates && \
    apk add --no-cache --virtual .build-deps python3-dev && \
    python3 -m ensurepip && pip3 install --upgrade pip && \
    pip3 install pytoml mistune beautifulsoup4 && \
    apk del .build-deps && \
    cp /usr/share/zoneinfo/EST /etc/localtime && \
    echo "CDT" > /etc/timezone && date && \
    rm -rf /var/cache/apk/*

CMD ["/srv/exec.sh"]
