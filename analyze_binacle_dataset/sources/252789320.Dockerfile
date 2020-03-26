FROM mariadb:10.3  
MAINTAINER duck. <me@duck.me.uk>  
  
RUN { \  
echo '[mysqld]'; \  
echo 'character-set-server=utf8mb4'; \  
echo 'collation-server=utf8mb4_unicode_ci'; \  
echo 'max-connections=250'; \  
echo '[client]'; \  
echo 'default-character-set=utf8mb4'; \  
} > /etc/mysql/conf.d/charset.cnf  

