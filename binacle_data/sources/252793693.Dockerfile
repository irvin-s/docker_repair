FROM nginx  
  
EXPOSE 80/tcp 443/tcp  
  
ADD self-signed-cert.cfg self-signed-cert.cfg  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
ADD reverse-proxy.conf /etc/reverse-proxy/reverse-proxy.conf  
  
# For debugging  
#RUN apt-get -y install procps vim tmux man less net-tools  
#RUN ln -sf /dev/stdout /var/log/nginx/error.log  
COPY nginx.conf /etc/nginx/nginx.conf  
  
VOLUME ["/etc/ssl/certs", "/etc/ssl/private", "/etc/reverse-proxy"]  
  
CMD ["/start.sh"]  
  

