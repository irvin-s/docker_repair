FROM scratch  
ADD rootfs.tar /  
ENV HOME /root  
CMD ["/bin/sh"]

