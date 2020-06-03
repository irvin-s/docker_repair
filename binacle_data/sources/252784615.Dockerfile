FROM blackikeeagle/alpine:edge  
MAINTAINER Ike Devolder, ike.devolder@gmail.com  
  
ENV C_USER php  
  
COPY ./container /container  
RUN /container/install-php.sh  
  
ADD ./entrypoint.sh /entrypoint.sh  
  
EXPOSE 9000  
WORKDIR /var/www  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["php-fpm"]  

