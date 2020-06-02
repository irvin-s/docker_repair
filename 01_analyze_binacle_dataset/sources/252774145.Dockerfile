FROM progrium/busybox  
  
MAINTAINER Amjad Masad <amjad.masad@gmail.com>  
  
ADD node-v5.0.0-linux-x64 /nodejs  
RUN opkg-install libstdcpp  
  
ENV PATH $PATH:/nodejs/bin  

