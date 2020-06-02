FROM scratch  
MAINTAINER Angus Lees <gus@inodes.org>  
  
ADD docker-image-minimal-docker-linux-x86_64-20160720062029.rootfs.tar.xz /  
CMD ["/bin/sh"]  

