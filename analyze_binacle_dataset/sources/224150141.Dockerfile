FROM alpine:edge

MAINTAINER Jim Ma <jim_ma@trendmicro.com.cn>

RUN apk add --update-cache \
    curl \
    ca-certificates \
    && rm -rf /var/cache/apk/*

ADD bin/ngrokd /usr/local/bin
ADD bin/ngrok /usr/local/bin
ADD ./run.sh /

RUN mkdir /ngrok
ADD ./ngrok.cfg /ngrok/
WORKDIR /ngrok

CMD ["/run.sh"]
