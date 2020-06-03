FROM httpd:2.4  
COPY ./build/ /usr/local/apache2/htdocs/  
#COPY ./beerbets-httpd.conf /usr/local/apache2/conf/httpd.conf  

