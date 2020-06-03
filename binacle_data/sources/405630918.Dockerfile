FROM alpine:3.9

RUN set -x && \
    addgroup -S user -g 1000 && \
    adduser -S user -G user && \
    apk add --no-cache bash
WORKDIR /home/user/bin
COPY bin .
RUN chmod +x *.sh
USER user

CMD exec /bin/sh -c "while true; do sleep 1000; done"
