FROM channeladam/consul-base:latest  
  
MAINTAINER Adam Craven <adam@ChannelAdam.com>  
  
COPY docker-entrypoint.sh /var/lib/channeladam-consul-server/  
RUN chmod +x /var/lib/channeladam-consul-server/docker-entrypoint.sh  
  
ENTRYPOINT ["/var/lib/channeladam-consul-server/docker-entrypoint.sh"]

