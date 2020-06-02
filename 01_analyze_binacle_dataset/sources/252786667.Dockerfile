FROM httpd:alpine  
MAINTAINER Denis Pettens <denis.pettens@gmail.com>  
  
EXPOSE 80/tcp  
  
COPY ./public_html/ /usr/local/apache2/htdocs/  

