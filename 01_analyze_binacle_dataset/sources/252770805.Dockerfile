FROM deardooley/php:5.6-composer  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>  
  
# Add project from current repo to enable automated build  
COPY . /var/www  
  
# Add custom entrypoint to inject runtime environment variables into  
# beanstalk console config  
COPY docker/run.sh /usr/local/bin/run  
  
RUN apk --update add php-ctype && \  
rm /var/cache/apk/* && \  
chown -R apache /var/www  
  
ENV DOCUMENT_ROOT /var/www/public  
  
WORKDIR /var/www  
  
CMD ["/usr/local/bin/run"]  

