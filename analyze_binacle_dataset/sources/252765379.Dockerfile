FROM progrium/busybox  
MAINTAINER Carlos Killpack <carlos@killpack.me>  
RUN opkg-install tor > /dev/null \  
&& mkdir -p /etc/tor /var/lib/tor \  
&& chown tor:tor /var/lib/tor  
VOLUME ["/etc/tor"]  
EXPOSE 9050  
CMD ["/usr/sbin/tor", "-f", "/etc/tor/torrc"]  

