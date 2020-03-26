from dorwardv/wordpress-sqlite-nginx-docker  
MAINTAINER philipp hoenisch <philipp@hoenisch.at>  
  
ADD wp-content /usr/share/nginx/html/wp-content/  
  
RUN chown -R www-data /usr/share/nginx/html/wp-content/  

