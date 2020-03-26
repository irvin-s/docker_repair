FROM alpine:3.5

RUN apk add --no-cache ca-certificates openssl bash

ENV LETSENCRYPT_RELEASE v1.0.0
ENV SSL_SCRIPT_COMMIT 08278ace626ada71384fc949bd637f4c15b03b53

RUN wget -O /usr/bin/update-rancher-ssl https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl

COPY package/rancher-entrypoint.sh /usr/bin/
COPY build/rancher-letsencrypt-linux-amd64 /usr/bin/rancher-letsencrypt

RUN chmod +x /usr/bin/rancher-letsencrypt

EXPOSE 80
ENTRYPOINT ["/usr/bin/rancher-entrypoint.sh"]
