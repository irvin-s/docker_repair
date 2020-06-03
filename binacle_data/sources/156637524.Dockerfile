FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum clean all; yum -y update; yum -y install net-tools bash-completion vim wget cronie at zlib-devel pcre-devel perl-devel perl-CPAN perl-Data-Dumper ncurses-devel cmake tcp_wrappers tcp_wrappers-devel openssl openssl-devel make gcc-c++ iptables; yum clean all

RUN useradd -r -s /sbin/nologin mysql \
        && cd /usr/local/src \
        && mysql_v=$(curl -s https://dev.mysql.com/downloads/mysql/ |grep "<h1>" |awk '{print $4}') && mysql_V=$(echo $mysql_v |awk -F. '{print $1"."$2}') \
        && wget -c http://dev.mysql.com/get/Downloads/MySQL-${mysql_V}/mysql-${mysql_v}.tar.gz

RUN cd /usr/local/src \
        && tar zxf mysql-*.tar.gz \
        && cd /usr/local/src/mysql-* \
        && cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
           -DMYSQL_DATADIR=/usr/local/mysql/data \
           -DMYSQL_UNIX_ADDR=/usr/local/mysql/tmp/mysql.sock \
           -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/src \
           -DDEFAULT_COLLATION=utf8_general_ci \
           -DDEFAULT_CHARSET=utf8 \
           -DWITH_LIBWRAP=1 \
           -DWITH_INNODB_MEMCACHED=1 \
           -DWITH_EXTRA_CHARSETS=all \
           -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
           -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
        && make -j8 &&  make install \
        && rm -rf /usr/local/src/* \
        && rm -rf /usr/local/boost \
        && ln -s /usr/local/mysql/bin/* /usr/bin/

RUN mkdir /docker-entrypoint-initdb.d

VOLUME /usr/local/mysql/data

COPY mysql.sh /mysql.sh
COPY backup.sh /backup.sh
RUN chmod +x /*.sh

ENTRYPOINT ["/mysql.sh"]

EXPOSE 3306

CMD ["mysqld_safe", "--federated"]

# docker build -t mysql .
# docker run -d --restart always -p 3306:3306 -v /docker/mysql:/usr/local/mysql/data -e MYSQL_ROOT_PASSWORD=newpass -e MYSQL_DATABASE=zabbix -e MYSQL_USER=zabbix -e MYSQL_PASSWORD=newpass -e MYSQL_BACK=Y --hostname mysql --name mysql mysql
# docker logs mysql |grep "PASSWORD"
# docker run -it --rm mysql --help
