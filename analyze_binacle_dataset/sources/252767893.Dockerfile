FROM binhex/arch-base  
MAINTAINER none  
  
ADD setup/*.conf /etc/supervisor/conf.d/  
ADD setup/root/*.sh /root/  
ADD apps/nobody/*.sh /home/nobody/  
  
RUN chmod +x /root/*.sh /home/nobody/*.sh && \  
/bin/bash /root/install.sh  
  
VOLUME ["/config"]  
VOLUME ["/books"]  
VOLUME ["/downloads"]  
  
EXPOSE 5299/tcp  
CMD ["/bin/bash", "/root/init.sh"]  
  

