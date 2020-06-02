FROM nickistre/centos-lamp:latest

COPY src/ /var/www/html/

RUN /etc/init.d/mysqld start \
    && mysqladmin -uroot password 'c2FkZmFnZGZkc3Nm' \
    && mysql -e "CREATE DATABASE blindsql DEFAULT CHARACTER SET utf8;" -uroot -pc2FkZmFnZGZkc3Nm \
    && mysql -e "use blindsql;source /var/www/html/blindsqli.sql;" -uroot -pc2FkZmFnZGZkc3Nm \
    && rm /var/www/html/blindsqli.sql \
    && rm /var/www/html/phpinfo.php \
    && chmod -R 655 /var/www/html/ 
