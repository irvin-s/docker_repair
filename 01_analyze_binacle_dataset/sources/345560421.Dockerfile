FROM ubuntu:trusty-20160503.1
MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=base \
    BITNAMI_PREFIX=/opt/bitnami \
    S6_OVERLAY_VERSION=1.16.0.2 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# Create bitnami user and added specific requirements
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y curl ca-certificates sudo libssl1.0.0 && \
  curl -LO https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz && \
  tar -zxf s6-overlay-amd64.tar.gz -C / && \
  adduser bitnami --disabled-password --gecos "" && \
  sed -i -e 's/\s*Defaults\s*secure_path\s*=/# Defaults secure_path=/' /etc/sudoers && \
  echo "bitnami ALL=NOPASSWD: ALL" >> /etc/sudoers && \
  apt-get clean && \
  rm -rf s6-overlay-amd64.tar.gz && \
  rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/*

COPY rootfs/ /
ENTRYPOINT ["/entrypoint.sh"]
