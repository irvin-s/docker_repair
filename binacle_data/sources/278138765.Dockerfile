FROM alpine:3.9

ARG DEPLOY_GID
ARG DEPLOY_UID

RUN apk upgrade --no-cache && rm -fR /etc/periodic
RUN apk add --no-cache bash python3 ca-certificates tzdata curl \
    && pip3 install s3cmd \
    && rm -fR /etc/periodic

ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.8/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=be43e64c45acd6ec4fce5831e03759c89676a0ea

RUN curl -fsSLO "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

COPY rootfs /
RUN chmod +x /usr/local/bin/*.sh

RUN echo '* * * * * /usr/local/bin/pull.sh' >/crontab

CMD ["/usr/local/bin/init.sh"]
