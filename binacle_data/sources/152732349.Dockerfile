FROM gcr.io/skia-public/basedebian:testing-slim

USER skia

COPY . /

ENTRYPOINT ["/usr/local/bin/autoroll-google3"]
