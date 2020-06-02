FROM dabsquared/php-fpm  
  
LABEL maintainer "dbrooks@dabsquared.com"  
  
WORKDIR /var/www/symfony  
  
RUN set -ex \  
&& apt-get clean && apt-get update \  
# install cron  
&& apt-get install -y cron \  
&& rm -rf /var/lib/apt/lists/*  
  
# Create the log file to be able to run tail  
RUN touch /var/log/cron.log  
  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD tail -f /var/log/cron.log  

