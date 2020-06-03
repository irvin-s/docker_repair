# OpenVPN  
#  
# Version 1.0  
FROM alpine  
  
# Only necessary if someone wants to pass in a custom config  
VOLUME /config  
  
# Update packages and install software  
RUN apk update && apk add openvpn  
  
ADD openvpn/ /etc/openvpn/  
  
ENV OPENVPN_USERNAME=**None** \  
OPENVPN_PASSWORD=**None** \  
OPENVPN_PROVIDER=**None**  
  
ENTRYPOINT /etc/openvpn/start.sh  

