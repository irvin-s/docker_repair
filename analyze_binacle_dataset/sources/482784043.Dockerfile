FROM quay.io/koli/base-os

RUN adduser --system \
    --shell /bin/bash \
    --disabled-password \
    --no-create-home \
    --group k8smutator

USER k8smutator
COPY . /

ENTRYPOINT ["/usr/bin/k8smutator"]
