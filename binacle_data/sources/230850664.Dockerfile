# イメージファイルをCentOS7に設定
FROM centos:7.3.1611

# 作成者記述
MAINTAINER tsukasa <t14159265358979323846@gmail.com>

# 実行コマンド設定
## nginx
RUN rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum -y update nginx-release-centos
RUN yum -y --enablerepo=nginx install nginx
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bk
ADD default.conf /etc/nginx/conf.d/
RUN systemctl enable nginx

## php
RUN yum -y install epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum -y install --enablerepo=remi,remi-php71 php php-devel php-mbstring php-pdo php-gd php-mysql php-mcrypt php-xdebug php-xml php-zip
RUN mv /etc/php.ini /etc/php.ini.bk
ADD php.ini /etc/php.ini

## php-fpm
RUN yum -y install php-fpm --enablerepo=epel --enablerepo=remi --enablerepo=remi-php71
RUN mv /etc/php-fpm.d/www.conf /etc/php-fpm.d/www.conf.bk
RUN systemctl enable php-fpm
ADD www.conf /etc/php-fpm.d/www.conf

## git
RUN yum install -y curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker wget && \
    cd /usr/local/src/ && \
    wget https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz && \
    tar xzvf git-2.9.3.tar.gz && \
    cd git-2.9.3 && \
    make prefix=/usr/local all && \
    make prefix=/usr/local install

# composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

## node.js,npm
RUN yum -y install epel-release bzip2
RUN yum -y update openssl
RUN yum-config-manager --enable cr
RUN yum -y install nodejs npm
RUN npm install -g n
RUN n latest

# 起動時実行コマンド
CMD ["/sbin/init"]
