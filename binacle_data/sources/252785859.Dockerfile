FROM busybox:1.24  
ADD proxy.sh /usr/sbin/  
  
ENTRYPOINT ["/usr/sbin/proxy.sh"]  

