FROM droptica/php-fpm:5-xdebug  
  
RUN pecl install xhprof-0.9.4  
  
ADD php5/xhprof/xhprof.ini $PHP_INI_DIR/conf.d/xhprof.ini  

