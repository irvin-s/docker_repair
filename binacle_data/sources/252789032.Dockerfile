FROM mariadb:10.0  
MAINTAINER drupal-docker  
  
ADD drupal.cnf /etc/mysql/conf.d/  

