FROM alpine:3.3  
RUN apk --no-cache add letsencrypt  
  
COPY ./build/root /var/spool/cron/crontabs  
  
VOLUME /etc/letsencrypt  
VOLUME /var/lib/letsencrypt  
VOLUME /var/www/acme-challenge  
  
CMD ["/usr/sbin/crond", "-f", "-l", "2", "-d", "2"]  

