FROM bitnami/apache:2.4.17-1-r02
ENV MYAPP_DIR=/app

COPY rootfs/ /
COPY code/ ${MYAPP_DIR}/

WORKDIR $MYAPP_DIR
