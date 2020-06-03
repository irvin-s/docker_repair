FROM alpine:3.7  
MAINTAINER Alastair Montgomery <alastair@montgomery.me.uk>  
  
RUN apk --update \  
add lighttpd && \  
rm -rf /var/cache/apk/*  
  
ADD lighttpd.conf /etc/lighttpd/lighttpd.conf  
RUN adduser www-data -G www-data -H -s /bin/false -D  
  
EXPOSE 80  
VOLUME /var/www  
  
ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]  
  

