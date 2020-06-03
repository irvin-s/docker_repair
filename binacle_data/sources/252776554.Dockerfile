FROM alpine  
  
RUN apk -U upgrade && \  
apk --update add \  
mariadb mariadb-client \  
&& \  
rm -rf /tmp/src && \  
rm -rf /var/cache/apk/*  
  
ADD my.cnf /etc/mysql/my.cnf  
RUN chmod 664 /etc/mysql/my.cnf  
  
ADD run /usr/local/bin/run  
RUN chmod +x /usr/local/bin/run  
  
VOLUME ["/var/lib/mysql"]  
EXPOSE 3306  
CMD ["/usr/local/bin/run"]  
  
RUN mkdir -p /run/mysqld  
  

