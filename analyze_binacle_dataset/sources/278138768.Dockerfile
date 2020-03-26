#region Modified Traefik build file
FROM alpine:3.8
RUN apk --no-cache add ca-certificates
RUN set -ex; \
	apkArch="$(apk --print-arch)"; \
	case "$apkArch" in \
		armhf) arch='arm' ;; \
		aarch64) arch='arm64' ;; \
		x86_64) arch='amd64' ;; \
		*) echo >&2 "error: unsupported architecture: $apkArch"; exit 1 ;; \
	esac; \
	wget --quiet -O /usr/local/bin/traefik "https://github.com/containous/traefik/releases/download/v1.7.9/traefik_linux-$arch"; \
	chmod +x /usr/local/bin/traefik
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["traefik"]

# Metadata
LABEL org.label-schema.vendor="Containous" \
      org.label-schema.url="https://traefik.io" \
      org.label-schema.name="Traefik" \
      org.label-schema.description="A modern reverse-proxy" \
      org.label-schema.version="v1.7.9" \
org.label-schema.docker.schema-version="1.0"
#endregion

RUN apk add --no-cache bash python3 ca-certificates tzdata \
    && pip3 install s3cmd \
    && rm -fR /etc/periodic

COPY traefik.toml /etc/traefik/traefik.toml

HEALTHCHECK --interval=5s --timeout=5s --start-period=120s CMD ["traefik","healthcheck"]
