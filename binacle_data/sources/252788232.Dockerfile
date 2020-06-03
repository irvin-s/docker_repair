# Dockerfile to create Mageia linux 6 base images  
# Create base image with mkimage-urpmi.sh script  
#  
FROM scratch  
MAINTAINER "Juan Luis Baptiste" <juancho@mageia.org>  
ADD rootfs.tar.xz /  

