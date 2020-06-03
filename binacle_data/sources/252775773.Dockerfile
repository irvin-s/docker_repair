FROM debian:jessie  
MAINTAINER philipp.holler93@googlemail.com  
  
# Set environment variables for build and entrypoint  
ENV OPENVPN_VERSION="2.3.4-5" \  
OPENVPN_CONFIG_FOLDER="/etc/openvpn"  
# Add user and group for the service to run under  
RUN groupadd -r openvpn \  
&& useradd -r -g openvpn openvpn  
  
# Install OpenVPN  
RUN apt-get update \  
&& apt-get install -y openvpn=2.3.4-5 \  
&& rm -r /var/lib/apt/lists/*  
  
# Volume for persistent data and configuration files  
VOLUME ${OPENVPN_CONFIG_FOLDER}  
  
# Expose the default OpenVPN port 1194  
EXPOSE 1194/udp  
  
# Add entrypoint script and set its permissions  
ADD /openvpn_entrypoint.sh /  
RUN chmod +x /openvpn_entrypoint.sh  
ENTRYPOINT ["/openvpn_entrypoint.sh"]

