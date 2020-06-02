FROM k0st/alpine-apache-php  
MAINTAINER Madhu Akula <madhu@appsecco.com>  
  
COPY get.php /app/get.php  
COPY ip.php /app/ip.php  
COPY post.php /app/post.php  
COPY sess.php /app/sess.php  

