FROM busybox  
  
MAINTAINER "Dmitry Momot" <mail@dmomot.com>  
  
RUN mkdir -p /var/www  
VOLUME ["/var/www"]  
CMD ["true"]  

