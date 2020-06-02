from ubuntu:latest  
run apt-get update -y  
run apt-get install apache2 -y  
copy index.html /var/www/html/  
expose 80  
cmd ["/usr/sbin/apache2ctl", "-DFOREGROUND"]  

