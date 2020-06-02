FROM ubuntu:16.04  
COPY icinga2.sh /tmp/icinga2.sh  
COPY run.sh /  
COPY nsca.conf /etc/supervisor/conf.d/nsca.conf  
COPY apache2_supervisor.conf /etc/supervisor/conf.d/apache2.conf  
  
RUN chmod +x /tmp/icinga2.sh && chmod +x /run.sh  
RUN /tmp/icinga2.sh  
  
VOLUME ["/icinga2conf","/mysql","/icingaweb2"]  
  
EXPOSE 80 8080 5667 5665  
CMD ["/run.sh"]  

