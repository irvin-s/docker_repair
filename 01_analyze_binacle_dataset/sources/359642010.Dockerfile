FROM hypriot/rpi-alpine-scratch:edge

# Add support for cross-builds
COPY qemu-arm-static /usr/bin/

RUN apk add --update curl
ADD grafana.tar /
COPY pods.json cluster.json /dashboards/
COPY run.sh /

ENTRYPOINT ["/run.sh"]
