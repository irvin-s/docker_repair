FROM scratch  
ADD rootfs.tar.xz /  
ENTRYPOINT ["/usr/bin/tini", "--"]  
CMD ["/bin/bash"]  

