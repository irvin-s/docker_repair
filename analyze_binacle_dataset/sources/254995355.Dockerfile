FROM microsoft/nanoserver:10.0.14393.1884

LABEL maintainer="Bo-Yi Wu <appleboy.tw@gmail.com>" \
  org.label-schema.name="Drone facebook" \
  org.label-schema.vendor="Bo-Yi Wu" \
  org.label-schema.schema-version="1.0"

COPY release/drone-facebook.exe C:/bin/drone-facebook.exe

ENTRYPOINT [ "C:\\bin\\drone-facebook.exe" ]
