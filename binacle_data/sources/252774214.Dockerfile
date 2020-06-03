FROM amazeeio/centos7-nginx:1.10  
COPY drupal.conf /etc/nginx/sites/drupal.conf  
  
RUN fix-permissions /etc/nginx  

