FROM xataz/alpine:3.3  
LABEL version="20160810/1"  
  
RUN apk add --update unbound curl  
RUN rm -rf /var/cache/apk/*  
  
RUN mkdir -p /var/cache/unbound && \  
chown unbound:unbound /var/cache/unbound  
  
ADD baddomains.sh /etc/periodic/daily/  
RUN chmod +x /etc/periodic/daily/baddomains.sh  
  
ADD entrypoint.sh /  
ADD start.sh /usr/bin/startup  
RUN chmod +x /entrypoint.sh && chmod +x /usr/bin/startup  
  
ADD unbound.conf /usr/local/etc/unbound/unbound.conf  
RUN chown -R unbound:unbound /usr/local/etc/unbound/  
  
EXPOSE 53/udp  
EXPOSE 53  
CMD ["tini","--","startup"]  

