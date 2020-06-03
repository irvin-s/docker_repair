#Version 0.0.1  
FROM fedora:latest  
MAINTAINER diegoserrano "dmserrano2010@gmail.com"  
ENV WP_VER 4.0.1  
RUN ["yum", "install", "-y", "httpd"]  
#RUN yum install -y httpd  
ENTRYPOINT ["/sbin/httpd", "-X"]  
ADD wordpress-$WP_VER.tar.gz /var/www/html/  
EXPOSE 80  

