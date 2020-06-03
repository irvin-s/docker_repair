FROM bash:4.4  
COPY netplugin-init /netplugin-init  
  
ENTRYPOINT ["/netplugin-init/init.sh"]  

