FROM php:5-apache-jessie

LABEL Author="Virink <virink@outlook.com>"
LABEL Blog="https://www.virzz.com"

COPY easy_laravel/ /var/www/html/

WORKDIR /var/www/html

RUN	sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
	sed -i '/security/d' /etc/apt/sources.list && \
	apt-get update -y && \
	# Git for composer
	apt-get -yqq install git && \
	# composer
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php --install-dir=/usr/local/bin && \
	mv /usr/local/bin/composer.phar /usr/local/bin/composer && \
	php -r "unlink('composer-setup.php');" && \
	composer install && \
	# Apache config
	sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/public/' /etc/apache2/sites-enabled/000-default.conf && \
    sed -i "166s/AllowOverride None/AllowOverride All/" /etc/apache2/apache2.conf && \
    ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/ && \
    # Database
    mv .env.example .env && \
	sed -i '/DB_DATABASE/d' .env && \
	touch database/database.sqlite && \
	php artisan key:generate && \
	php artisan migrate && \
    php artisan db:seed && \
    php artisan vendor:publish --provider="Laracasts\\Flash\\FlashServiceProvider" && \
    # Database admin password reset
    mv reset_admin_passwd.sh /usr/local/bin/reset_admin_passwd.sh && \
    chmod +x /usr/local/bin/reset_admin_passwd.sh && \
    # Flag
    mv flag.php ./storage/flag.php && \
    cp ./storage/flag.php ./storage/framework/views/73eb5933be1eb2293500f4a74b45284fd453f0bb.php && \
    touch -t 209911111111.11 ./storage/framework/views/73eb5933be1eb2293500f4a74b45284fd453f0bb.php && \
    mv docker-php-entrypoint /usr/local/bin/docker-php-entrypoint && \
    mv reset_admin_passwd.php /usr/local/bin/reset_admin_passwd && \
    chmod +x /usr/local/bin/docker-php-entrypoint && \
    echo 'flag{good_job_for_you}' > /th1s1s_F14g_2333333 && \
    chown -R www-data:www-data . && \
    chmod 777 -R storage/ && \
    rm -rf /etc/apt/*

ENTRYPOINT ["sh", "-c", "docker-php-entrypoint"]