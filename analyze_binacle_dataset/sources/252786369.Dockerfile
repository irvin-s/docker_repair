FROM dockage/alpine-confd:3.7  
MAINTAINER Mohammad Abdoli Rad <m.abdolirad@gmail.com>  
  
LABEL org.label-schema.name="alpine-php-fpm" \  
org.label-schema.vendor="Dockage" \  
org.label-schema.description="Docker PHP-FPM image built on Alpine Linux" \  
org.label-schema.vcs-url="https://github.com/dockage/alpine-php-fpm" \  
org.label-schema.license="MIT"  
  
COPY assets/root/ /  
  
RUN apk --no-cache --update add php7-fpm \  
&& rc-update add php-fpm7 default  
  
EXPOSE 9000

