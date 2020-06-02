# vim:set ft=dockerfile:  
FROM alpine:latest  
  
MAINTAINER Andrius Kairiukstis <andrius@kairiukstis.com>  
  
RUN apk add --update \  
asterisk \  
asterisk-speex \  
asterisk-sample-config \  
asterisk-curl \  
asterisk-srtp \  
&& rm -rf /usr/lib/asterisk/modules/*pjsip* \  
&& rm -rf /var/cache/apk/* /tmp/* /var/tmp/*  
  
# start asterisk so it creates missing folders and initializes astdb  
RUN asterisk && sleep 2  
  
ADD docker-entrypoint.sh /docker-entrypoint.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "root", "-p"]  
  

