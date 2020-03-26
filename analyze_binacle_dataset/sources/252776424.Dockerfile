FROM richarvey/nginx-php-fpm  
  
MAINTAINER Lindsay Evans <lindsay.evans@boomworks.com.au>  
  
RUN apk --no-cache add \  
bash \  
build-base \  
curl \  
libffi-dev \  
ruby \  
ruby-bundler \  
ruby-dev \  
ruby-io-console \  
wget  
  
# Install Sass & Compasss Ruby gems  
RUN gem install sass compass --no-ri --no-rdoc  
  
# Set supervisord to run in daemon mode  
RUN sed -i 's/supervisord -n/supervisord/g' /start.sh  
  
# Add our wrapper script  
ADD scripts/run.sh /run.sh  
RUN chmod 755 /run.sh  
  
WORKDIR /var/www/html/  
  
# Run webserver & sass watch by default  
CMD "/run.sh"  

