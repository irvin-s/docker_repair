FROM scratch  
MAINTAINER christopher@horrell.ca  
ADD rootfs.tar.xz /  
ENTRYPOINT ["/bin/node"]  

