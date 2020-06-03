FROM drupal:8.2-apache  
MAINTAINER Antonis Kalipetis <akalipetis@gmail.com>  
  
RUN for dir in modules sites themes; do \  
mv /var/www/html/$dir /var/www/html/$dir.install; \  
ln -s /mnt/data/$dir /var/www/html/$dir; \  
done  
COPY entrypoint.sh /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["apache2-foreground"]  

