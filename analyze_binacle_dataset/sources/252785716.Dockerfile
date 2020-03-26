FROM huangxiangyu/centos-systemd  
  
ADD . /root/compass-deck  
  
RUN /root/compass-deck/build.sh  
  
EXPOSE 80  
CMD ["/sbin/init", "/usr/local/bin/start.sh"]  

