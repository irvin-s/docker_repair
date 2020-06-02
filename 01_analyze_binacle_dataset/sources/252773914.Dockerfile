FROM alpine:3.7  
# root filesystem  
COPY rootfs /  
  
# container builder, let sh run it  
RUN /bin/sh /scripts/build.sh  
  
# port  
EXPOSE 3306  
# volumes  
VOLUME ["/var/lib/mysql"]  
  
# launch command  
CMD ["/scripts/wrapper/mysqld.sh"]  

