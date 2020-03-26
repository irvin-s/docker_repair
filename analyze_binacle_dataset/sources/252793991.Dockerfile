FROM debian:stable-slim  
  
MAINTAINER <suriya@neutron.in.th>  
  
RUN export DEBIAN_FRONTEND=noninteractive && \  
apt-get update && \  
apt-get -y install dnsmasq && \  
rm -rf /var/lib/apt/lists/*  
  
EXPOSE 53 53/udp  
ENTRYPOINT ["dnsmasq", "-k"]  

