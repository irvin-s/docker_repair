FROM microsoft/nanoserver:10.0.14393.1884

LABEL maintainer="Bo-Yi Wu <appleboy.tw@gmail.com>" \
  org.label-schema.name="Drone telegram" \
  org.label-schema.vendor="Bo-Yi Wu" \
  org.label-schema.schema-version="1.0"

ADD release/drone-telegram.exe /drone-telegram.exe
ENTRYPOINT [ "\\drone-telegram.exe" ]
