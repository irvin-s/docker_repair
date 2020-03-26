FROM alpine:3.6  
LABEL maintainer="Jeeva S. Chelladhurai <sjeeva@gmail.com>"  
  
RUN apk add --no-cache apache2 && \  
mkdir -p /run/apache2 && \  
echo "<html><h1>Docker Cookbook</h1></html>" > \  
/var/www/localhost/htdocs/index.html  
  
EXPOSE 80  
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]  

