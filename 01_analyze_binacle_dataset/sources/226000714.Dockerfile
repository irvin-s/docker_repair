FROM alpine:latest

RUN addgroup -S centrifugo && adduser -S -G centrifugo centrifugo \
    && mkdir /centrifugo && chown centrifugo:centrifugo /centrifugo \
    && mkdir /var/log/centrifugo && chown centrifugo:centrifugo /var/log/centrifugo

ADD centrifugo /usr/bin/centrifugo

VOLUME ["/centrifugo", "/var/log/centrifugo"]

WORKDIR /centrifugo

USER centrifugo

CMD ["centrifugo"]

EXPOSE 8000
