FROM alpine:3.7  
# root filesystem  
COPY rootfs /  
  
# container builder, let sh run it  
RUN /bin/sh /scripts/build.sh  
  
# volumes  
VOLUME ["/www/conf", "/www/htdocs", "/www/sites", "/www/logs", "/www/backup"]  
  
# port  
EXPOSE 80  
# init - zombie reaping  
ENTRYPOINT ["/bin/smell-baron"]  
  
# launch command  
CMD ["-f", "nginx", "-g", "daemon off;", "---", "/scripts/wrapper/php-fpm.sh"]  

