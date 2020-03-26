# docker run -d -p 3306:3306 boris/mariadb:latest  
FROM alpine:latest  
  
MAINTAINER Boris Quiroz <boris@insert-coin.org>  
  
EXPOSE 3306  
RUN apk --update add mysql && \  
mkdir -p /var/lib/mysql && \  
{ \  
echo '[mysqld]'; \  
echo 'user = root'; \  
echo 'datadir = /var/lib/mysql'; \  
echo 'port = 3306'; \  
echo 'log-bin = /var/lib/mysql/mysql-bin'; \  
} > /etc/mysql/my.cnf \  
&& rm -rf /usr/share/ri  
VOLUME ["/var/lib/mysql", "/etc/mysql/conf.d/"]  
  
RUN mkdir -p /run/mysqld/  
CMD ["mysqld", "--skip-grant-tables", "--user=root"]  

