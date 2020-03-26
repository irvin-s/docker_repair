FROM activ/arch-openvpn  
MAINTAINER activ  
  
# additional files  
##################  
ADD setup/*.conf /etc/supervisor/conf.d/  
ADD setup/root/*.sh /root/  
ADD apps/root/*.sh /root/  
ADD apps/nobody/*.sh /home/nobody/  
  
# install app  
#############  
# make executable and run bash scripts to install app  
RUN chmod +x /root/*.sh /home/nobody/*.sh && \  
/bin/bash /root/install.sh  
  
# docker settings  
#################  
VOLUME ["/config"]  
VOLUME /data  
  
EXPOSE 9091/tcp  
  
  
# set permissions  
#################  
# run script to set uid, gid and permissions  
CMD ["/bin/bash", "/root/init.sh"]

