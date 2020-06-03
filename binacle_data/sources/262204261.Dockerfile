FROM nickistre/centos-lamp:latest

COPY src/ /var/www/html/
COPY httpd.conf /etc/httpd/conf/

RUN rm /var/www/html/phpinfo.php \
    && chmod -R 755 /var/www/html/ \
    && chmod -R 777 /var/www/html/app2/upload/ \
    && chmod -R 755 /var/www/html/app2/upload/index.html
