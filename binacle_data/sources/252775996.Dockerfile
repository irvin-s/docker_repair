FROM mysql:latest  
  
ENV MYSQL_ROOT_PASSWORD=root  
ENV MYSQL_DATABASE=magento  
ENV MYSQL_USER=magento  
ENV MYSQL_PASSWORD=magento  
  
COPY docker-entrypoint.sh /usr/local/bin/  

