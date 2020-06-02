FROM ubuntu

ENV BORG_LATEST_SCRIPT_URL=https://gist.github.com/m3adow/d3a4479742c56fe77e3cf6fc0d405e8e/raw/borg-latest.sh \
    BORG_PATH=/usr/local/bin/borg

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y wget \
  && wget -O /usr/local/bin/borg-latest.sh "${BORG_LATEST_SCRIPT_URL}" \
  && chmod +x /usr/local/bin/borg-latest.sh \
  && /usr/local/bin/borg-latest.sh -V \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/log/*

ENTRYPOINT ["/usr/local/bin/borg-latest.sh"]
