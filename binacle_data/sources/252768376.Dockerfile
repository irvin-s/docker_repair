FROM alpine  
  
ENV SQUID_CACHE_DIR=/var/spool/squid \  
SQUID_LOG_DIR=/var/log/squid  
  
RUN apk add --update squid bash \  
&& mv /etc/squid/squid.conf /etc/squid/squid.conf.dist  
  
COPY squid.conf /etc/squid/squid.conf  
COPY entrypoint.sh /sbin/entrypoint.sh  
RUN chmod 755 /sbin/entrypoint.sh  
  
EXPOSE 3128/tcp  
VOLUME ["${SQUID_CACHE_DIR}"]  
ENTRYPOINT ["/sbin/entrypoint.sh"]

