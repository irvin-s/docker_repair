FROM scratch  
ADD rootfs.tar.xz /  
CMD ["/bin/bash"]  
COPY ./qemu-arm-static /usr/local/bin/  

