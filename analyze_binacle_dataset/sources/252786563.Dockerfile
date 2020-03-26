FROM dockerstabil/php:7.2.5-cli  
  
# box  
RUN composer global require humbug/php-scoper:^1.0@dev humbug/box:^3.0@alpha  
ENTRYPOINT ["box"]  
CMD []  

