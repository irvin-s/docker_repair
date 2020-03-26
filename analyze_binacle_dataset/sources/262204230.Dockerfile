FROM nickistre/centos-lamp:latest

COPY src/ /var/www/html/

RUN /etc/init.d/mysqld start \
    && mysqladmin -uroot password 'YXNkamZoNzJzZHNmc2c' \
    && mysql -e "CREATE DATABASE skctf DEFAULT CHARACTER SET utf8;" -uroot -pYXNkamZoNzJzZHNmc2c \
    && mysql -e "use skctf;source /var/www/html/admin.sql;" -uroot -pYXNkamZoNzJzZHNmc2c \
    && rm /var/www/html/admin.sql \
    && rm /var/www/html/phpinfo.php \
    && chmod -R 755 /var/www/html
