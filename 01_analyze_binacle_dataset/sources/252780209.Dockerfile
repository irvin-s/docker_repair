FROM azmo/base:debian-slim  
LABEL maintainer "Gordon Schulz <gordon.schulz@gmail.com>"  
  
RUN apt-get update && apt-get -y --no-install-recommends install openvpn \  
iptables iputils-ping iputils-tracepath traceroute grep \  
iproute2 curl ca-certificates ufw procps ipcalc && apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY setup/00-ufw.sh /etc/cont-init.d/00-ufw  
COPY setup/01-allowed-routes.sh /etc/cont-init.d/01-allowed-routes  
COPY bin/openvpn.sh /etc/services.d/openvpn/run  
ARG OPENVPN_HEALTHCHECK  
COPY healthcheck/healthcheck.sh ${OPENVPN_HEALTHCHECK}  
  
VOLUME /etc/openvpn/config  

