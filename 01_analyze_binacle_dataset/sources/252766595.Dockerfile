FROM timonier/aria2:latest  
  
ENV \  
ARIA_RPC_PORT="" \  
ARIA_RPC_SECRET="" \  
ARIA_DIR="/var/lib/seedbox" \  
ARIA_ENABLE_DHT="false" \  
ARIA_MAX_CONCURRENT_DOWNLOADS="10" \  
USER=root  
COPY aria2wrapper.sh /  
CMD /aria2wrapper.sh  
  

