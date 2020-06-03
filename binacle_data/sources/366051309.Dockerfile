FROM alpine:3.5

ARG HAPROXY_MAJOR
ARG HAPROXY_VERSION
ARG HAPROXY_MD5
ARG WITH_LUA
ARG BUILD_DATE

# Build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.name="HAProxy" \
	org.label-schema.description="A TCP/HTTP reverse proxy for high availability environments" \
	org.label-schema.url="http://www.haproxy.org" \
	org.label-schema.version=$HAPROXY_VERSION \
	org.label-schema.vcs-url="https://github.com/janeczku/docker-alpine-haproxy" \
	org.label-schema.build-date=$BUILD_DATE \
	org.label-schema.schema-version="1.0"

COPY build.sh /
RUN /build.sh
CMD [ "/usr/sbin/haproxy-systemd-wrapper", "-p", "/run/haproxy.pid", "-f", "/etc/haproxy/haproxy.cfg" ]
