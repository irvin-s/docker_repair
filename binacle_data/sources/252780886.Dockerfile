# This Dockerfile is used to create ArchLinux mirror  
# with no effort.  
FROM alpine:3.3  
MAINTAINER Jérémy SEBAN <jeremy@seban.eu>  
  
RUN apk add --update rsync nginx ruby && rm -rf /var/cache/apk  
COPY ./entrypoint.sh /bin/entrypoint  
COPY ./watchdog.rb /bin/watchdog  
COPY ./arch-mirror.config.default.yml /etc/arch-mirror.config.default.yml  
COPY ./nginx.conf /etc/nginx/nginx.conf  
RUN chmod +x /bin/entrypoint /bin/watchdog  
  
VOLUME ["/etc/arch-mirror", "/var/mirror"]  
  
ENTRYPOINT ["/bin/entrypoint"]  
  
CMD ["/bin/watchdog"]  

