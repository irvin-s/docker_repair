FROM alpine:latest  
MAINTAINER atomney <atomney+docker@gmail.com>  
ADD start-squid.sh /start-squid.sh  
RUN apk add --no-cache squid curl && \  
chown -R squid:squid /var/cache/squid && \  
chown -R squid:squid /var/log/squid && \  
chmod +x /start-squid.sh && \  
squid -z  
EXPOSE 3128  
#ENTRYPOINT ["/usr/sbin/squid","-NYCd","1"]  
ENTRYPOINT ["/start-squid.sh"]  

