FROM alpine:latest  
  
RUN apk add --no-cache dhcp && \  
touch /var/lib/dhcp/dhcpd.leases  
  
ENTRYPOINT ["/usr/sbin/dhcpd", "-user", "dhcp", "-f"]  
CMD  

