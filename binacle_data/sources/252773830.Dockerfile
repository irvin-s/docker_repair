# a naive PHP + mcrypt image  
FROM php:5.6.6-cli  
  
  
# install PHP modules  
# ... via a convenient wrapper for "make ; make install" stuff  
# start PHP  
ENTRYPOINT [ "php" ]

