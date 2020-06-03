FROM bamarni/php:7-cli  
  
RUN composer create-project sismo/sismo:1.* /root/sismo \  
&& cd /root/sismo \  
&& php compile  
  
EXPOSE 80  
  
CMD php /root/sismo/build/sismo.php run 0.0.0.0:80  

