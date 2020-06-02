FROM envoy-base

COPY conf/envoy.yaml /etc/envoy/envoy.yaml

COPY conf/spiffe-envoy-agent.conf /etc/spiffe-envoy-agent.conf

COPY conf/spire-agent.conf /opt/spire/conf/agent/agent.conf
COPY conf/agent.key.pem /opt/spire/conf/agent/agent.key.pem
COPY conf/agent.crt.pem /opt/spire/conf/agent/agent.crt.pem
COPY conf/proxy-cacert.pem /etc/ssl/certs/proxy-cacert.pem

COPY web-server /usr/local/bin/web-server

WORKDIR /opt/spire
