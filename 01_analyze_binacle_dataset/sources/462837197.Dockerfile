FROM alpine:3.6 as base

RUN apk add --no-cache curl && \
  curl -sSLo /bin/manifest-tool https://github.com/estesp/manifest-tool/releases/download/v0.7.0/manifest-tool-linux-armv7 && \
  chmod +x /bin/manifest-tool

FROM plugins/base:multiarch

LABEL maintainer="Drone.IO Community <drone-dev@googlegroups.com>" \
  org.label-schema.name="Drone Manifest" \
  org.label-schema.vendor="Drone.IO Community" \
  org.label-schema.schema-version="1.0"

COPY --from=base /bin/manifest-tool /bin/

ADD release/linux/arm/drone-manifest /bin/
ENTRYPOINT ["/bin/drone-manifest"]
