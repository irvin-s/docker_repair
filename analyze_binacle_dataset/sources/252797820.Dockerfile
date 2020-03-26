FROM progrium/busybox  
  
VOLUME /data  
WORKDIR /data  
  
RUN opkg-install curl bash git  
CMD ["/bin/bash"]

