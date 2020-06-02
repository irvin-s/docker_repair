FROM nickistre/centos-lamp:latest

COPY public/ /var/www/html

RUN /etc/init.d/mysqld start \
    && mysqladmin -uroot password 'cTf_p@ssw0rD' \
    && mysql -uroot -pcTf_p@ssw0rD test < /var/www/html/test.sql \
    && rm /var/www/html/test.sql \
    && rm /var/www/html/phpinfo.php \
    && chmod -R 755 /var/www/html
