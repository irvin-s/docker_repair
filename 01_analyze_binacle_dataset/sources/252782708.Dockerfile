FROM tutum/apache-php:latest  
MAINTAINER Rob Edwards  
  
ADD index.php /app/index.php  
ADD images/* /app/images/  
ADD css/style.css /app/css/style.css  
  
EXPOSE 80  
WORKDIR /app  
CMD ["/run.sh"]  

