FROM lighthouse.examples.base

COPY configs/haproxy-proxies.yaml /etc/lighthouse/balancers/haproxy.yaml
COPY configs/discovery/zookeeper.yaml /etc/lighthouse/discovery/
COPY configs/services/partner-proxy.yaml /etc/lighthouse/services/

# proxied request port
EXPOSE 7777
