FROM composer:1.5  
# add a non-root user and give them ownership  
RUN adduser -D -u 9000 app && \  
# repo  
mkdir /repo && \  
chown -R app:app /repo && \  
# collector code  
mkdir /usr/src/collector && \  
chown -R app:app /usr/src/collector  
  
# run everything from here on as non-root  
USER app  
  
ADD composer.json /usr/src/collector  
ADD composer.lock /usr/src/collector  
RUN cd /usr/src/collector && composer install  
  
ADD entrypoint.php /usr/src/collector  
  
WORKDIR /repo  
  
ENTRYPOINT ["php", "/usr/src/collector/entrypoint.php"]  

