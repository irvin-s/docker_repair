FROM ubuntu:14.04  
  
MAINTAINER Erik Osterman "e@osterman.com"  
RUN apt-get update && \  
apt-get -y install socat  
  
ENTRYPOINT ["/usr/bin/socat"]  
  
USER root  
  
# E.g. Proxy OpenVPN  
# e.g. UDP4-RECVFROM:1194,fork UDP4-SENDTO:vpn.host:1194  
CMD ["-h"]  
  

