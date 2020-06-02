FROM goldy/tor-hidden-service  
  
ENV PORT 80  
ADD assets/torrc /etc/tor/torrc  

