FROM debian:stretch  
MAINTAINER artem.silenkov@gmail.com  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN rm -rf /var/lib/apt/lists/*  
  
RUN apt-get update  
  
RUN apt-get install -y libboost-system1.62.0 libgcc1 libstdc++6 \  
liblog4cplus-1.1-9 libmariadbclient18 libpq5 \  
libssl1.1 zlib1g curl jq  
  
ADD debs /opt/debs  
  
RUN rm -rf /opt/debs/debian  
  
RUN cd /opt/debs ; dpkg -i *  
  
RUN rm -rf /opt/debs  
  
RUN apt-get -y dist-upgrade \  
&& apt-get -y install net-tools tcpdump iptables \  
&& cp -r /etc/kea /etc/kea.orig \  
&& apt-get clean  
  
ADD scripts/run.sh /  
  
ADD files/id_rsa /opt/kea/napi/id_rsa  
ADD files/kea-hook-runscript.so /opt/kea/napi/kea-hook-runscript.so  
ADD files/napi.sh /opt/kea/napi/napi.sh  
  
RUN apt-get clean  
  
RUN mkdir -p /var/run/kea/ /var/kea/  
  
EXPOSE 67 67/udp 547 547/udp 647 647/udp 847 847/udp 8686  
ENTRYPOINT ["/run.sh"]  
CMD ["/usr/sbin/kea-dhcp4","-c","/etc/kea/kea-dhcp4.conf"]  
VOLUME ["/etc/kea","/var/lib/kea"]  
WORKDIR /etc/kea  

