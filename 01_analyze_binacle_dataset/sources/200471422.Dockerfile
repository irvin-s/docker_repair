FROM m3adow/borg

ENV BORG_UPDATE_ONLY=1
COPY borgmatic_entrypoint.sh /usr/local/bin/

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
  && apt-get install -y python3 python3-pip\
  && pip3 install --upgrade borgmatic \
  && apt-get purge -y python3-pip \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/log/* \
  && chmod +x /usr/local/bin/borgmatic_entrypoint.sh

ENTRYPOINT ["/usr/local/bin/borgmatic_entrypoint.sh"]
