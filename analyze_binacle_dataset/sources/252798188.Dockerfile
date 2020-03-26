FROM nginx:1.9.9  
RUN apt-get update  
RUN apt-get install -y php5-fpm  
RUN apt-get install -y php5-curl  
RUN apt-get install -y php5-gd  
RUN apt-get install -y php5-json  
RUN apt-get install -y php5-mysql  
  
RUN touch /usr/local/bin/entrypoint.sh  
RUN chmod +x /usr/local/bin/entrypoint.sh  
  
RUN rm -rf /var/lib/apt/lists/*  
  
RUN usermod -u 1000 www-data  
  
WORKDIR /var/www/html  
  
EXPOSE 80 443  
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

