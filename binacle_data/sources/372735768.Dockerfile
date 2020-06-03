#
# Dockerfile for Caddy https://caddyserver.com/
# Addopted from https://github.com/abiosoft/caddy-docker
#
FROM alpine:latest

ARG container_version=0.0.0.0

LABEL maintainer="Plone Community" \
    org.label-schema.vendor="Plone Community" \
    caddy_version="0.10.6" \
    architecture="amd64" \
    build_version="$container_version"

ENV PIP_CACHE /root/.cache

RUN builddeps=' \
        tar \
        curl \
        git \
        '\
        && apk --no-cache add \
        $builddeps \
        ca-certificates \
        su-exec \
        python2 \
        dcron \
        libxslt \
        bash \
        py-pip \
        tini \
        openssh-client \
    && mkdir -p /srv/venus \
    && git clone https://github.com/rubys/venus.git /srv/venus/source \
    && pip2 install --upgrade pip \
    && pip2 install honcho \
	&& curl --silent --show-error --fail --location \
		--header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
		"https://caddyserver.com/download/linux/amd64?plugins=http.minify" \
	| tar --no-same-owner -C /usr/bin/ -xz caddy \
	&& chmod 0755 /usr/bin/caddy \
    && /usr/bin/caddy -version \
    && apk del --purge $builddeps \
    && rm -rf $PIP_CACHE

COPY dockerfiles/Caddyfile /etc/Caddyfile
COPY dockerfiles/crontab.tmp /etc/cron.d/planet.cron
COPY dockerfiles/Procfile /srv/Procfile
COPY dockerfiles/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN crontab /etc/cron.d/planet.cron

WORKDIR /srv/venus
COPY planet planet.plone.org

#EXPOSE 80 443 2015

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#ENTRYPOINT ["/bin/bash"]
