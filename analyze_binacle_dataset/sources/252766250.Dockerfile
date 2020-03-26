FROM alpine:latest  
RUN apk --no-cache add tzdata dnsmasq-dnssec curl  
  
EXPOSE 53 53/udp  
  
RUN mkdir -p /etc/dnsmasq.d/  
COPY config/dnsmasq.conf /etc/dnsmasq.conf  
COPY entrypoint.sh /sbin/entrypoint.sh  
COPY update.sh /sbin/update.sh  
  
VOLUME ["/etc/dnsmasq.d/"]  
  
ENTRYPOINT ["/sbin/entrypoint.sh"]  
  
CMD ["dnsmasq", "--no-daemon"]  

