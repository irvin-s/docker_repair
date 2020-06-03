FROM alpine:latest  
MAINTAINER Justin Honold "astrostl@github"  
RUN apk --update add logrotate  
  
COPY src/ /  
  
VOLUME ["/etc/logrotate.d"]  
  
ENTRYPOINT ["/usr/sbin/logrotate","/etc/logrotate.d/docker-logrotate.conf"]  
CMD [""]  

