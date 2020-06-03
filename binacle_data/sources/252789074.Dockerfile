FROM dsbaars/go-ethereum:debian-src-stable  
MAINTAINER dsbaars  
  
ENV NETWORK_ID 1234  
ENV DATADIR /tmp/gethdata  
  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

