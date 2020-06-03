FROM scratch  
EXPOSE 3000  
ADD /rootfs.tar.xz /  
USER 99  
ENTRYPOINT ["/bin/https-redirect",":3000"]  

