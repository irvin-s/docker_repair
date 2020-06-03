FROM alizarion/httpd:latest  
  
ADD mod_openid_conf.template /tmp/  
ADD entrypoint.sh /  
  
RUN chmod +x /entrypoint.sh  
  
RUN rm -f /etc/httpd/conf.d/welcome.conf  
RUN rm -f /usr/share/httpd/noindex/index.html  
ADD index.html /usr/share/httpd/noindex/  
RUN chmod 777 /usr/share/httpd/noindex/index.html  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["httpd-foreground"]  

