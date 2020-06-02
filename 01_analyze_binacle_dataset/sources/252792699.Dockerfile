FROM alpine:3.4  
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>  
RUN apk --update --no-cache add docker  
COPY dockerd-entrypoint.sh /usr/local/bin/  
COPY dockerd-cmd.sh /usr/local/bin/  
COPY setup-compose /usr/local/bin/  
EXPOSE 2375  
ENTRYPOINT ["dockerd-entrypoint.sh"]  
CMD ["dockerd-cmd.sh"]  

