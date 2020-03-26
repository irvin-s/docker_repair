# dekobon/bouncy-haproxy:latest  
FROM phusion/baseimage:0.9.17  
MAINTAINER Elijah Zupancic <elijah@zupancic.name>  
  
# Syslog setup  
RUN sed -i '/source s_src {/,/};/d' /etc/syslog-ng/syslog-ng.conf  
COPY etc/syslog-ng/conf.d/sources.conf /etc/syslog-ng/conf.d/sources.conf  
  
RUN apt-add-repository ppa:vbernat/haproxy-1.5 && \  
apt-get -q update && \  
apt-get upgrade -qy -o Dpkg::Options::="--force-confold" && \  
apt-get install -qy haproxy curl wget vim nano && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
ADD etc/service/haproxy/run /etc/service/haproxy/run  
RUN chmod +x /etc/service/haproxy/run  
  
ADD etc/haproxy/haproxy-template.cfg /etc/haproxy/haproxy-template.cfg  
RUN mkdir -pv /etc/haproxy/config && \  
sed -i 's/\/dev\/log/127.0.0.1/g' /etc/haproxy/haproxy.cfg && \  
sed -i '/^.*chroot.*$/d' /etc/haproxy/haproxy.cfg && \  
cp -v /etc/haproxy/haproxy.cfg /etc/haproxy/config/haproxy.cfg && \  
cat /etc/haproxy/haproxy-template.cfg >> /etc/haproxy/config/haproxy.cfg  
  
VOLUME ["/etc/haproxy/config"]

