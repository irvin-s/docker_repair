FROM fedora/apache  
MAINTAINER Dan Kenigsberg <danken@gmail.com>  
RUN dnf install -y hspell perl perl-CGI && dnf clean all  
RUN sed -i "s/^Listen 80$/Listen 8080/" /etc/httpd/conf/httpd.conf  
RUN echo RedirectMatch ^/$ /cgi-bin/hspell.cgi >> /etc/httpd/conf/httpd.conf  
COPY hspell.cgi hspell.color.cgi color.pl /var/www/cgi-bin/  
COPY hebrew.conf /etc/httpd/conf.d  
RUN chown -R apache:apache /var/log/httpd  
RUN chown -R apache:apache /run/httpd  
RUN chmod -R o+rwx /var/log/httpd  
RUN chmod -R o+rwx /run/httpd  
USER 999999  

