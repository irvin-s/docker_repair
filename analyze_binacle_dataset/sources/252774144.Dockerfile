FROM progrium/busybox  
  
MAINTAINER Amjad Masad <amjad.masad@gmail.com>  
  
ADD iojs-v1.4.3-linux-x64 /iojs  
RUN opkg-install libstdcpp  
  
ENV PATH $PATH:/iojs/bin  

