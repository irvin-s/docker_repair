FROM clickandmortar/apache-php  
  
MAINTAINER Click & Mortar <contact@clickandmortar.fr>  
  
# Custom Symfony vhost  
ADD symfony.conf /etc/apache2/sites-available/000-default.conf  
  
# Supervisord  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
# Start  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod 755 /entrypoint.sh  
  
CMD ["/entrypoint.sh"]  

