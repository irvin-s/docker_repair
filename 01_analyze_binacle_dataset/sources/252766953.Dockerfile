FROM ubuntu:14.04  
WORKDIR /root  
  
COPY scripts .  
  
RUN chmod +x *  
  
RUN ./upgrade_system.sh  
  
RUN ./setup_system.sh  
  
RUN ./get_senginx.sh  
  
RUN \  
echo "daemon off;" >> /usr/local/senginx/conf/nginx.conf  
  
CMD ["/usr/local/senginx/sbin/nginx"]

