FROM alpine:edge  
  
RUN apk update \  
&& apk add mysql-client \  
&& apk add bash \  
&& rm -rf /var/cache/apk/*  
  
ENV STORAGE_DIRECTORY "/var/storage"  
ENV MYSQL_DATABASE ""  
ENV MYSQL_USER ""  
ENV MYSQL_PASSWORD ""  
ENV MYSQL_HOST ""  
ENV MYSQL_PORT 3306  
ENV DATESTAMP_FORMAT "%Y%m%d-%H%M%S"  
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
ADD cli.sh /usr/local/bin/cli  
ADD dump.sh /usr/local/bin/dump  
ADD import.sh /usr/local/bin/import  
  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["mysql-cli.sh"]  

