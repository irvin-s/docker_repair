FROM ubuntu:14.04  
RUN apt-get update  
RUN apt-get -y install openvpn  
ENTRYPOINT [ "openvpn", "--config", "/etc/openvpn/server.conf"]

