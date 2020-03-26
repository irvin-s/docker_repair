FROM binhex/arch-base  
MAINTAINER none  
  
ADD setup/*.conf /etc/supervisor/conf.d/  
ADD setup/root/*.sh /root/  
ADD setup/root/*.yml /root/  
ADD apps/nobody/*.sh /home/nobody/  
  
RUN chmod +x /root/*.sh /home/nobody/*.sh && \  
/bin/bash /root/install.sh  
  
VOLUME ["/config"]  
VOLUME ["/mnt"]  
  
EXPOSE 3539/tcp  
CMD ["/bin/bash", "/root/init.sh"]  
  

