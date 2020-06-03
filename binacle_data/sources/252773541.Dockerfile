FROM alpine:latest  
MAINTAINER billyplus <web.erigame.com>  
  
# Environments  
ENV TIMEZONE Asia/Shanghai  
  
WORKDIR /app  
VOLUME /app  
COPY startup.sh /startup.sh  
RUN chmod -R 755 /startup.sh  
  
RUN apk add --update mysql && rm -f /var/cache/apk/* && \  
echo "${TIMEZONE}" > /etc/TZ  
COPY my.cnf /etc/mysql/my.cnf  
  
EXPOSE 3306  
ENTRYPOINT ["/startup.sh"]  
CMD ["/usr/bin/mysqld","--user=root", "--console"]  

