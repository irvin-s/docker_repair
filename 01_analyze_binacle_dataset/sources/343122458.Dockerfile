FROM alpine

RUN wget -P /usr/local/bin https://github.com/3XX0/donkey/releases/download/v1.1.0/donkey && \
    chmod +x /usr/local/bin/donkey

ARG FOO
RUN donkey get $FOO >&2

ARG BAR
RUN donkey get $BAR >&2
RUN donkey get $BAR sh -c 'cat $DONKEY_FILE' >&2
