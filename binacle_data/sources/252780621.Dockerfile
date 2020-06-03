FROM copex/php  
  
RUN apt-get update && \  
apt-get --no-install-recommends -y --force-yes install \  
ruby \  
zip \  
unzip  
  
RUN gem install capistrano -v 3.4.0 && \  
gem install capistrano-scm-gitcopy -v 0.1.5 && \  
gem install capistrano-magento2  
  
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  
RUN php composer-setup.php  
RUN php -r "unlink('composer-setup.php');"

