FROM composer  
RUN composer global require friendsofphp/php-cs-fixer:2.3  
COPY run-php-cs-test.sh /usr/local/bin/run-php-cs-test.sh  
COPY default.txt /default.txt  
VOLUME /src  
WORKDIR /src  
ENTRYPOINT ["run-php-cs-test.sh"]  

