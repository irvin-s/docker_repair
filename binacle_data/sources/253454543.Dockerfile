FROM plugins/base:multiarch

LABEL maintainer="Bo-Yi Wu <appleboy.tw@gmail.com>" \
  org.label-schema.name="Drone Line" \
  org.label-schema.vendor="Bo-Yi Wu" \
  org.label-schema.schema-version="1.0"

ADD release/linux/arm/drone-line /bin/

ENTRYPOINT ["/bin/drone-line"]
