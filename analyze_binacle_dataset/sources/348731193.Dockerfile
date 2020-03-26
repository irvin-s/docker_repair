FROM centos:7

RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    rpm -ivh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && \
    rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB && \
    yum -y install yum-plugin-protectbase.noarch \
        unzip \
        wget \
        nginx \
        php56w \
        php56w-opcache \
        php56w-cli \
        php56w-intl \
        php56w-mbstring \
        php56w-mcrypt \
        php56w-mysqlnd \
        php56w-xml \
        php56w-fpm \
        mariadb-server \
        mariadb-client

RUN rm -rf /etc/nginx/nginx.conf /etc/php-fpm.d/www.conf

COPY entrypoint.sh /
COPY wordpress/* /opt/wordpress/
COPY nginx/conf/nginx.conf /etc/nginx/
COPY nginx/conf.d/* /etc/nginx/conf.d/
COPY php-fpm.d/php-fpm.www.conf /etc/php-fpm.d/php-fpm.www.conf

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 80 3306

VOLUME /var/lib/mysql

VOLUME /vagrant/docker/wordpress

CMD ["nginx", "-g", "daemon off;"]
