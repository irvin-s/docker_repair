FROM hipache:0.2.8  
EXPOSE 80 443  
CMD ["/start"]  
  
ADD start.sh /start  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
ADD config.json /usr/local/lib/node_modules/hipache/config/config.json  

