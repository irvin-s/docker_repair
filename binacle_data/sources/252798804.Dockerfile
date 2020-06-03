FROM php:7.1-alpine  
MAINTAINER Kanin Peanviriyakulkit <kanin.pean@gmail.com>  
RUN apk update \  
&& apk add --no-cache \  
openldap-dev \  
libldap \  
&& docker-php-ext-configure ldap --with-libdir=lib/ \  
&& docker-php-ext-install ldap  
WORKDIR /usr/src  
EXPOSE 80  
CMD ["php", "-S", "0.0.0.0:80", "-t", "public"]  
ADD ./entrypoint.sh /entrypoint.sh  
RUN chmod 755 /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
COPY ./src /usr/src  

