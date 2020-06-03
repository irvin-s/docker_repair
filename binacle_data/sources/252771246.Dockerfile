FROM drupal:8.1  
MAINTAINER Ain Tohvri <ain@flashbit.net>  
  
RUN apt-get update && apt-get install -y \  
vim \  
drush  
  
RUN curl https://drupalconsole.com/installer -L -o drupal.phar \  
&& mv drupal.phar /usr/local/bin/drupal \  
&& chmod +x /usr/local/bin/drupal \  
&& drupal init --override \  
&& drupal check  
  
EXPOSE 80  
WORKDIR /var/www/html  
  
CMD ['apache2-foreground']  

