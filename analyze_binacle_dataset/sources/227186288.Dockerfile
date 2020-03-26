FROM alpine:3.4

MAINTAINER Eric Pfeiffer <computerfr33k@users.noreply.github.com>

ARG CADDY_HOST_HTTP_PORT_1=80
ARG CADDY_HOST_HTTP_PORT_2=443
ARG CADDY_HOST_HTTP_PORT_3=8080

ENV caddy_version=0.10.0

LABEL caddy_version="$caddy_version" architecture="amd64"

RUN apk update \
    && apk upgrade \
    && apk add tar curl git

RUN curl --silent --show-error --fail --location \
        --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
        "https://caddyserver.com/download/linux/amd64?plugins=http.authz,http.awslambda,http.cgi,http.cors,http.datadog,http.expires,http.filemanager,http.filter,http.git,http.gopkg,http.grpc,http.hugo,http.ipfilter,http.jwt,http.login,http.mailout,http.minify,http.prometheus,http.proxyprotocol,http.ratelimit,http.realip,http.reauth,http.restic,http.upload,tls.dns.cloudflare,tls.dns.digitalocean,tls.dns.dnsimple,tls.dns.dnspod,tls.dns.dyn,tls.dns.exoscale,tls.dns.gandi,tls.dns.googlecloud,tls.dns.linode,tls.dns.namecheap,tls.dns.ovh,tls.dns.rackspace,tls.dns.rfc2136,tls.dns.route53,tls.dns.vultr" \
        | tar --no-same-owner -C /usr/bin/ -xz caddy \
    && mv /usr/bin/caddy /usr/bin/caddy \
    && chmod 0755 /usr/bin/caddy

EXPOSE ${CADDY_HOST_HTTP_PORT_1} ${CADDY_HOST_HTTP_PORT_2} ${CADDY_HOST_HTTP_PORT_3}

WORKDIR /var/www/public

CMD ["/usr/bin/caddy", "-conf", "/etc/Caddyfile"]
