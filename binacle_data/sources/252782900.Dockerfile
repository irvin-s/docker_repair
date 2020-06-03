FROM scratch  
  
ADD openwrt-15.05-x86-generic-Generic-rootfs.tar.gz /  
  
RUN mkdir /var/lock && opkg update  
USER root  
CMD cat /etc/banner && /bin/sh  

