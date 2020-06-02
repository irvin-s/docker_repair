FROM httpd:2.2
#COPY ./public-html/ /usr/local/apache2/htdocs/
#COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf


#RUN sed -i 's@#LoadModule ssl_module modules/mod_ssl.so@LoadModule ssl_module modules/mod_ssl.so@' /usr/local/apache2/conf/httpd.conf

# Exposed ports
EXPOSE 80
