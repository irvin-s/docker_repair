FROM bitnami/minideb

RUN install_packages wget ca-certificates
RUN wget -O /usr/bin/kubecfg https://github.com/ksonnet/kubecfg/releases/download/v0.5.0/kubecfg-linux-amd64
RUN chmod +x /usr/bin/kubecfg

CMD ["kubecfg"]
