FROM tvial/docker-mailserver  
LABEL maintainer="gaetanlongree@gmail.com"  
  
COPY config /tmp/config  
COPY entrypoint.sh /  
  
VOLUME /var/mail  
VOLUME /var/mail-state  
VOLUME /tmp/docker-mailserver  
  
ENTRYPOINT ["bash", "/entrypoint.sh"]  
  
CMD supervisord -c /etc/supervisor/supervisord.conf  
  

