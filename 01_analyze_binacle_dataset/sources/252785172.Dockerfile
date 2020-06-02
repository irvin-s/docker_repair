FROM cogentwebs/base  
  
MAINTAINER Pichate Ins <cogent@cogentwebworks.com>  
  
# Set labels  
LABEL com.mariadb.cogentwebworks.version="0.1.0-beta"  
  
ENV MYSQL_DATABASE=docker_db  
ENV MYSQL_USER=user_db  
ENV MYSQL_PASSWORD=password_db  
ENV MYSQL_ROOT_PASSWORD=root_db  
ENV LANG=en_US.utf8  
ENV MYDATA=/var/lib/lib/mysql  
ENV MY_TRUST_LOCALNET=true  
ENV MY_MAJOR=10  
ENV MY_VERSION=10.1  
### Files Addition  
ADD rootfs /  
  
RUN addgroup -S mysql && adduser -S -G mysql mysql  
### Build Postgresql  
RUN apk-install mariadb mariadb-client pwgen su-exec && apk-clean  
  
## VOLUME  
VOLUME ["/var/lib/mysql"]  
  
## Networking Configuration  
EXPOSE 3306  
### Entrypoint Configuration  
ENTRYPOINT ["/init"]  

