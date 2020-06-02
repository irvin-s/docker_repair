FROM scratch  
  
MAINTAINER Burak Erturk "<burakerturk@pisilinux.org>"  
ADD chroot.tar.xz /  
  
RUN pisi rr depo && service dbus start  
  
  
  
CMD ["/usr/bin/bash"]

