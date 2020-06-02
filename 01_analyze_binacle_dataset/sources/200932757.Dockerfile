# Base image to use, this must be set as the first line
FROM ansible/centos7-ansible:1.7

# Maintainer: docker_user <docker_user at email.com> (@docker_user)
MAINTAINER yangyifan yangyifanphp@gmail.com

# 暴露的端口
EXPOSE 80

# 下载二进制源码包（已经下载，直接把本地的移到容器里面去）
#RUN wget http://nginx.org/download/nginx-1.9.9.tar.gz  #下载地址 http://nginx.org/en/download.html
#RUN wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre2-10.10.tar.gz  #下载地址 ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/
#RUN wget http://zlib.net/zlib-1.2.8.tar.gz # 下载地址 http://www.zlib.net/
#RUN wget http://www.openssl.org/source/openssl-1.0.2e.tar.gz # 下载地址 http://www.openssl.org/source/
#RUN wget http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.28.tar.gz # 下载地址 http://dev.mysql.com/downloads/mysql/
#RUN wget http://cn2.php.net/distributions/php-5.6.16.tar.gz # 下载地址 http://php.net/get/php-5.6.16.tar.gz/from/a/mirror
#RUN wget http://download.redis.io/releases/redis-3.0.6.tar.gz # 下载地址 http://redis.io/
#RUN wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz # 下载地址 http://mcrypt.hellug.gr/lib/

# 移到文件到容器
COPY ["soft/", "/usr/local/src/"]

# 操作yum源
RUN yum install -y wget
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN cd /etc/yum.repos.d/;wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
RUN yum clean all
RUN yum makecache

# 下载依赖包
RUN yum install -y gcc gcc-c++ autoconf libxml libxml2-devel libcurl libcurl-devel libpng libpng-devel freetype freetype-devel gd gd-devel libjpeg libjpeg-devel openssl libvpx libvpx-devel libmcrypt libmcrypt-devel ncurses ncurses-devel wget openssl openssl-devel pcre pcre-devel vim cmake bzip2

# 解压文件
RUN cd /usr/local/src/;tar zxf mysql-5.6.28.tar.gz
RUN cd /usr/local/src/;tar zxf redis-3.0.6.tar.gz
RUN cd /usr/local/src/;tar zxf nginx-1.9.9.tar.gz
RUN cd /usr/local/src/;tar zxf php-5.6.16.tar.gz
RUN cd /usr/local/src/;tar zxf libmcrypt-2.5.7.tar.gz

# 操作nginx编译
RUN cd /usr/local/src/nginx-1.9.9;./configure --prefix=/usr/local/nginx-1.9.9 --with-pcre --with-http_ssl_module --with-http_stub_status_module && make && make install 

# 操作redis
RUN cd /usr/local/src/redis-3.0.6/ && make && make install PREFIX=/usr/local/redis-3.0.6
RUN cd /usr/local/src/redis-3.0.6/;cp redis.conf /usr/local/redis-3.0.6/

# 操作mysql
RUN mkdir -p /usr/local/www/data/mysql/data
RUN groupadd mysql
RUN useradd -g mysql mysql
RUN chown -R mysql:mysql /usr/local/www/data/mysql/data
RUN cd /usr/local/src/mysql-5.6.28;cmake -DMYSQL_USER=mysql -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/www/data/mysql/data -DSYSCONFDIR=/etc -DMYSQL_USER=mysql -DMYSQL_UNIX_ADDR=/tmp/mysql/mysql.sock  -DDEFAULT_CHARSET=utf8  -DDEFAULT_COLLATION=utf8_general_ci -DEXTRA_CHARSETS=all -DWITH_EMBEDDED_SERVER=1 -DENABLED_LOCAL_INFILE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_TCP_PORT=3306 -DWITH_SSL:STRING=bundled -DWITH_ZLIB:STRING=bundled && make && make install

#操作mysql配置文件
COPY ["./soft/mysql/my.cnf", "/etc/my.cnf"]
COPY ["./soft/mysql/my.cnf.d/", "/etc/my.cnf.d/"]

# 初始化mysql
#RUN /usr/local/mysql/scripts/mysql_install_db --basedir=/usr/local/mysql/ --datadir=/usr/local/www/data/mysql/data --defaults-extra-file=/etc/my.cnf --user=mysql --pid-file=/usr/local/www/data/mysql/data/mysql.pid
#RUN mkdir -p /var/log/mariadb/ && chown -R mysql:mysql /var/log/mariadb/

# 操作 php
RUN cd /usr/local/src/libmcrypt-2.5.7 && ./configure && make && make install

RUN cd /usr/local/src/php-5.6.16;./configure --prefix=/usr/local/php5.6 --with-config-file-path=/usr/local/php5.6/etc --with-mysql=mysqlnd --with-pdo-mysql=mysqlnd --with-mysqli=mysqlnd --with-iconv-dir --with-freetype-dir --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir --enable-xml --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --with-curlwrappers --enable-mbregex --enable-fastcgi --enable-fpm --enable-mbstring --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-sockets --with-xmlrpc --enable-zip --enable-soap --enable-ftp  --with-mcrypt=/usr/local/src/libmcrypt-2.5.7 && make && make install
RUN cd /usr/local/src/php-5.6.16;cp php.ini-production /usr/local/php5.6/etc/php.ini
RUN cd /usr/local/php5.6/etc/ &&  mv php-fpm.conf.default php-fpm.conf



# 设置挂载
VOLUME ["/usr/local/nginx/html", "/usr/local/www"] # 前面这个是我本地的代码存放目录，详细的可以自定义，后面这个是容器存放代码的地方

# 容器运行时的指令
CMD /usr/local/nginx-1.9.9/sbin/nginx # 运行nginx
CMD /usr/local/mysql/support-files/mysql.server start # 运行mysql
CMD /usr/local/php5.6/sbin/php-fpm # 运行php-fpm
CMD /usr/local/redis-3.0.6/bin/redis-server /usr/local/redis-3.0.6/redis.conf # 运行redis

