FROM ubuntu  
MAINTAINER tashun-su <antoniost29@gmail.com>  
RUN apt-get update  
RUN apt-get install -y apache2  
EXPOSE 80  
CMD service apache2 start && tail -f /var/log/apache2/access.log  
# docker build -t ubuntu-apache-httpd -f Dockerfile PATH  
# docker run -i -t --rm -p 80:80 ubuntu-apache-httpd  

