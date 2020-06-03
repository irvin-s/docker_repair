FROM centos

#RUN yum update -y
RUN yum install -y mod_php php-gd php-mbstring php-mysql git

WORKDIR /var/www
RUN git clone https://github.com/fc2blog/blog.git && \
  chown apache:apache blog/app/temp blog/public/uploads && \
  sed \
    -e "s/'localhost'/getenv('MYSQL_PORT_3306_TCP_ADDR')/" \
    -e "s/your user name/@DB_USER@/" \
    -e "s/your password/@DB_PASSWORD@/" \
    -e "s/your database name/@DB_DATABASE@/" \
    -e "s/UTF8MB4/UTF8/" \
    -e "s/'domain'/\$_SERVER['HTTP_HOST']/" \
    -e "s/0123456789abcdef/@PASSWORD_SALT@/" \
    blog/public/config.php.sample > blog/public/config.php && \
  ( \
    echo "<VirtualHost *:80>" && \
    echo "  DocumentRoot /var/www/blog/public" && \
    echo "  <Directory /var/www/blog/public>" && \
    echo "    AllowOverride All" && \
    echo "    Order allow,deny" && \
    echo "    Allow from all" && \
    echo "  </Directory>" && \
    echo "</VirtualHost>" \
  ) > /etc/httpd/conf.d/fc2blog.conf
