FROM bankrate/docker-php:1.0  
# Add the composer automatic installer script.  
ADD scripts/composer.sh /usr/local/bin/composer.sh  
  
# Create the on build actions for this container.  
ONBUILD ADD . /app/  
ONBUILD RUN /bin/bash /usr/local/bin/composer.sh  
ONBUILD RUN /bin/chown -R app:app /app  

