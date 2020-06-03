FROM debian:9  
RUN apt-get update && apt-get install -y bind9 && rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /var/run/named /etc/bind/zones  
  
RUN chmod 755 /var/run/named  
  
RUN chown root:bind /var/run/named > /dev/nul 2>&1  
  
EXPOSE 53  
EXPOSE 53/udp  
  
CMD ["/usr/sbin/named","-g","-c","/etc/bind/named.conf","-u","bind"]  
  

