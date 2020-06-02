FROM crux/base:latest  
MAINTAINER James Mills <prologic@shortcircuitnet.au>  
  
EXPOSE 6667  
VOLUME /var/lib/bitlbee  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["/start.sh"]  
  
RUN groupadd -r bitlbee && \  
useradd -r -d /var/lib/bitlbee -g bitlbee bitlbee  
  
RUN ports -u && prt-get cache && \  
prt-get depinst glib && \  
prt-get depinst bitlbee && \  
rm -rf /usr/ports/*  
  
COPY bitlbee.conf /etc/bitlbee/  
COPY entrypoint.sh /  
COPY start.sh /  

