FROM progrium/busybox  
  
MAINTAINER Alex Laskin <alex@lask.in>  
  
RUN opkg-install unbound  
  
EXPOSE 53/udp 53/tcp  
  
ADD remote-control /etc/unbound/remote-control  
ADD *.conf /etc/unbound/  
  
ADD http://www.internic.net/domain/named.root /etc/unbound/root.hints  
  
ENTRYPOINT ["/usr/sbin/unbound"]  
CMD [""]  

