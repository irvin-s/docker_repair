FROM bitnami/minideb:jessie
# Why not Alpine? No glibc. Not willing to shave the yak of compiling with musl right now.
# Why not busybox? No libpthread, and no package manager to install libpthread.

RUN apt-get update && apt-get upgrade -y 
RUN install_packages ca-certificates
COPY dnsmetrics /usr/bin/dnsmetrics

CMD ["/usr/bin/dnsmetrics", "-config", "/local/config.yml"]
