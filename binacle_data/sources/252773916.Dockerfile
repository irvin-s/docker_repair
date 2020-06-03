FROM alpine:3.7  
# root filesystem  
COPY rootfs /  
  
# container builder, let sh run it  
RUN /bin/sh /scripts/build.sh  
  
# port  
EXPOSE 3128  
# volumes  
VOLUME ["/var/cache/squid", "/var/log/squid"]  
  
# launch command  
CMD ["/scripts/wrapper/squid.sh"]  

