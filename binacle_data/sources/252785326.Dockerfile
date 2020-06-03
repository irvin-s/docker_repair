FROM colindensem/nginx  
MAINTAINER Colin Densem "hello@summit360.co.uk"  
COPY config/etc /etc  
  
VOLUME ["/srv/application"]  
  
# EXPOSE  
EXPOSE 80  
CMD ["nginx"]  
  

