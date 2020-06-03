FROM debian:jessie  
MAINTAINER chakphanu@gmail.com  
  
COPY src/apt /etc/apt  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update \  
&& apt-get -y dist-upgrade \  
&& apt-get -y install net-tools tcpdump \  
&& apt-get -t testing -y install \  
kea-admin kea-dhcp-ddns-server kea-dhcp4-server kea-dhcp6-server \  
iptables \  
&& cp -r /etc/kea /etc/kea.orig \  
&& apt-get clean  
  
ADD src/starter.sh /  
  
EXPOSE 67 67/udp 547 547/udp 647 647/udp 847 847/udp  
  
ENTRYPOINT ["/starter.sh"]  
CMD ["/usr/sbin/kea-dhcp4","-c","/etc/kea/kea-dhcp4.conf"]  
VOLUME ["/etc/kea","/var/lib/kea"]  
WORKDIR /etc/kea  

