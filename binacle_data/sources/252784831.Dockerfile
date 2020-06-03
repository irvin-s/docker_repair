FROM scratch  
MAINTAINER Josh VanderLinden <codekoala@gmail.com>  
  
ENV container docker  
ADD arch-rootfs-2016.03.14.tar.gz /  
  
CMD ["/bin/bash"]  
  
# vim:ft=Dockerfile:  

