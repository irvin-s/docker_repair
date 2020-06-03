FROM armel/busybox

COPY registry /
COPY config.yml /etc/docker/registry/config.yml

CMD ["/registry", "serve", "/etc/docker/registry/config.yml"]
