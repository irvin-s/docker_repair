FROM digitalcz/supervisor:trusty  
  
RUN apt-get update && apt-get install -y apache2  
RUN mkdir -p /var/lock/apache2 /var/run/apache2  
  
COPY apache.sv.conf /etc/supervisor/conf.d/apache.sv.conf  
  
WORKDIR /var/www/html  
  
EXPOSE 80 443

