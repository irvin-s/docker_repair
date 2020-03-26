FROM plabedan/gentoo-minimal

RUN emerge --sync
#RUN emerge -u @world
RUN ( \
      echo dev-lang/php apache2 cjk gd mysql mysqli pdo && \
      echo app-admin/eselect-php apache2 && \
      echo dev-vcs/git -gpg -perl -python -webdav \
    ) >> /etc/portage/package.use
RUN emerge dev-lang/php dev-vcs/git

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
    echo "DocumentRoot /var/www/blog/public" && \
    echo "<Directory /var/www/blog/public>" && \
    echo "  AllowOverride All" && \
    echo "  Order allow,deny" && \
    echo "  Allow from all" && \
    echo "</Directory>" \
  ) > /etc/apache2/vhosts.d/default_vhost.include && \
  echo ja_JP.UTF-8 UTF-8 >> /etc/locale.gen && \
  locale-gen
