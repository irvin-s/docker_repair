FROM alpine:edge  
  
RUN apk update \  
&& apk add mysql \  
&& apk add mysql-client \  
&& apk add pwgen \  
&& apk add expect \  
&& rm -rf /var/cache/apk/*  
  
RUN mkdir -p /run/mysqld  
RUN chown mysql:mysql /run/mysqld  
  
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh  
  
ENV MYSQL_ROOT_PASSWORD ""  
ENV APP_USER "app"  
ENV APP_PASSWORD ""  
ENV APP_PRIVILEGES "ALL"  
ENV DATABASE_NAME "app"  
ENTRYPOINT ["docker-entrypoint.sh"]  
  
CMD ["mysqld_safe", "--user", "mysql"]  

