FROM nginx:1.9  
MAINTAINER Adam Paterson <hello@adampaterson.co.uk>  
  
ADD etc/vhost.conf /etc/nginx/conf.d/default.conf  
ADD bin/* /usr/local/bin  
  
ENV FPM_HOST fpm  
ENV FPM_PORT 9000  
ENV SYLIUS_ROOT /var/www/sylius  
ENV SYLIUS_RUN_MODE dev  
ENV DEBUG false  
  
ENTRYPOINT ["/usr/local/bin/docker-environment"]  
CMD ["nginx", "-g", "daemon off;"]

