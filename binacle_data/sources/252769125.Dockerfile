FROM andytruong/drupal:7.34  
  
COPY ./quizz.make /var/www/quizz.make  
RUN rm -rf /var/www/html && drush make /var/www/quizz.make /var/www/html  
RUN ls -lah /var/www/html/sites/all/modules/contrib  
COPY ./local.settings.php /var/www/html/sites/default/local.settings.php  

