FROM busybox  
  
VOLUME /datadir  
VOLUME /etc/openvpn  
VOLUME /var/log  
VOLUME /var/log/nginx  
VOLUME /usr/share/nginx/html/keys  
CMD ["true"]  

