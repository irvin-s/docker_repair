FROM dockenizer/alpine  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apk --update add mysql && \  
rm -rf /var/cache/apk/*  
  
ADD my.cnf /etc/mysql/my.cnf  
ADD run.sh /run.sh  
  
RUN chmod +x /run.sh  
  
EXPOSE 3306  
VOLUME ["/var/lib/mysql"]  
CMD ["/run.sh"]

