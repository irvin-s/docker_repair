FROM ubuntu:xenial

LABEL description="Istio CNI plugin installer."

RUN apt-get update && apt-get install -qqy --no-install-recommends \
jq='1.5*' \
&& rm -rf /var/lib/apt/lists/*

COPY istio-cni /opt/cni/bin/
COPY istio-iptables.sh /opt/cni/bin/
COPY install-cni.sh /install-cni.sh
COPY filter.jq /filter.jq
COPY istio-cni.conf.default /istio-cni.conf.tmp

ENV PATH=$PATH:/opt/cni/bin
VOLUME /opt/cni
WORKDIR /opt/cni/bin
CMD ["/install-cni.sh"]
