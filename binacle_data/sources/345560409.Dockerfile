FROM bitnami/base-alpine:3.2
MAINTAINER Bitnami <containers@bitnami.com>

ONBUILD COPY help.txt $BITNAMI_PREFIX/help.txt
ONBUILD COPY installer.run.sha256 /tmp/installer.run.sha256
ONBUILD COPY post-install.sh /tmp/post-install.sh
