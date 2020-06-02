FROM aatarasoff/nomad:0.2
ADD ./config /config/
VOLUME /data

ENTRYPOINT ["/bin/nomad", "agent", "-config=/config/config.hc1"]
