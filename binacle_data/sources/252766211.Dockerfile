FROM tutum/apache-php  
  
MAINTAINER Alejandro Baez  
  
  
RUN apt-get update && apt-get install -yq git postgresql  
  
RUN rm /app -rf  
RUN git clone https://github.com/Flyspray/flyspray.git /app  
RUN touch /app/flyspray.conf.php  
  
WORKDIR /app  
  
RUN composer self-update  
RUN composer install  
  
RUN chown www-data:www-data /app -R  
  
WORKDIR /  
  
VOLUME /app/attachments  
VOLUME /app/cache  
VOLUME /app/setup  
  
CMD ["php ", "-S 0.0.0.0:80 ", "-t /app"]  

