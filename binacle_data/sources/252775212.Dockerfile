# Dockerfile for icinga2 as monitored client  
FROM debian:jessie  
  
MAINTAINER Benedikt Heine  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
ADD content/ /  
  
RUN apt-key add /opt/setup/icinga2.key \  
&& apt-get -q update \  
&& apt-get -qy upgrade \  
&& apt-get -qy install --no-install-recommends \  
ethtool \  
icinga2 \  
monitoring-plugins \  
net-tools \  
procps \  
smartmontools \  
snmp \  
sysstat \  
sudo \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
# Final fixes  
RUN true \  
&& mv /etc/icinga2/ /etc/icinga2.dist \  
&& mkdir /etc/icinga2 \  
&& chmod u+s,g+s \  
/bin/ping \  
/bin/ping6 \  
/usr/lib/nagios/plugins/check_icmp  
  
EXPOSE 80 443 5665  
  
ENTRYPOINT ["/opt/run"]  

