# Dockerfile to create NLAN agent image
#
# Original image "router" have already openvswitch
# preinstalled.

FROM router
ENV TEGA_ADDRESS 172.17.0.1
ENV NO_PROXY 172.17.0.1,localhost
ADD agent /root/bin/agent
CMD service openvswitch-switch start && service quagga start && service ssh start && /root/bin/agent

