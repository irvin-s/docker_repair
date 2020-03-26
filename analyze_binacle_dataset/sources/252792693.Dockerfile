FROM alpine:3.4  
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>  
  
ADD /apk /apk  
RUN cp /apk/.abuild/-57e3e78d.rsa.pub /etc/apk/keys  
RUN apk --update --no-cache add /apk/bro-2.4.1-r0.apk \  
&& rm -rf /apk /tmp/* /var/cache/apk/*  
CMD ["/bin/sh"]  

