FROM oraclelinux:latest  
  
MAINTAINER Cartesoft  
  
RUN yum install -y httpd  
RUN yum install -y php  
  
EXPOSE 80  
ADD index.php /var/www/html/index.php  
  
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]  

