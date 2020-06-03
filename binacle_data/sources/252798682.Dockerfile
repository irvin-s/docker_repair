# dockerflix + openvpn  
#  
# based on:  
# * Dockerflix: https://github.com/trick77/dockerflix  
# * OpenVPN Client: https://github.com/schmas/docker-openvpn-client  
#  
FROM phusion/baseimage:0.9.17  
MAINTAINER derrod <xlnedder@gmail.com>  
  
# Evironment variables  
ENV DEBIAN_FRONTEND=noninteractive \  
OPENVPN_USERNAME=**None** \  
OPENVPN_PASSWORD=**None** \  
OPENVPN_PROVIDER=**None**  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
RUN apt-get -qq update  
RUN apt-get -y install python-software-properties \  
&& add-apt-repository ppa:dlundquist/sniproxy \  
&& apt-get update && apt-get -y install sniproxy \  
&& apt-get install -y openvpn inetutils-traceroute inetutils-ping wget curl \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Create runit services  
RUN mkdir /etc/sniproxy  
# ADD ./config/dockerflix-sniproxy.conf /etc/sniproxy/sniproxy.conf  
RUN mkdir /etc/service/sniproxy  
ADD ./config/run_sniproxy /etc/service/sniproxy/run  
RUN chmod +x /etc/service/sniproxy/run  
  
EXPOSE 22 80 443  
# Enabling SSH  
RUN rm -f /etc/service/sshd/down  
  
# Enabling the insecure key permanently  
RUN /usr/sbin/enable_insecure_key  
  
# Volumes  
VOLUME /config  
VOLUME /etc/sniproxy  
VOLUME /var/log/sniproxy  
  
# Adding utils scripts to bin  
ADD bin/ /usr/local/bin/  
RUN chmod +x /usr/local/bin/*  
  
# Add configuration and scripts  
ADD openvpn /etc/openvpn  
RUN chmod +x /etc/openvpn/bin/* \  
&& mkdir -p /etc/openvpn/up \  
&& mkdir -p /etc/openvpn/down \  
&& ln -s /usr/local/bin/ssh-restart /etc/openvpn/up/00-ssh-restart \  
&& ln -s /usr/local/bin/my-public-ip-info /etc/openvpn/up/01-my-public-ip-info  
  
# Running scripts during container startup  
RUN mkdir -p /etc/my_init.d \  
&& ln -s /etc/openvpn/bin/openvpn-setup.sh /etc/my_init.d/openvpn-setup.sh \  
&& chmod +x /etc/my_init.d/*  
  
# Add to runit  
RUN mkdir /etc/service/openvpn \  
&& ln -s /etc/openvpn/bin/openvpn-run.sh /etc/service/openvpn/run \  
&& ln -s /etc/openvpn/bin/openvpn-finish.sh /etc/service/openvpn/finish \  
&& chmod +x /etc/service/openvpn/run \  
&& chmod +x /etc/service/openvpn/finish  
  
# Final cleanup  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

