### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ENV TERM dumb

ADD run /usr/local/bin/
ADD dump /usr/local/bin/
RUN apk add  -U mysql mariadb-client bash && \
	rm -rf /var/cache/apk/* && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /etc/mysql/conf.d && \
    mkdir -p /run/mysqld/ && \
    { \
        echo '[mysqld]'; \
        echo 'user = root'; \
        echo 'datadir = /var/lib/mysql'; \
        echo 'port = 3306'; \
        echo 'log-bin = /var/lib/mysql/mysql-bin'; \
        echo '!includedir /etc/mysql/conf.d/'; \
    } > /etc/mysql/my.cnf && \
    chmod +x /usr/local/bin/run && chmod +x /usr/local/bin/dump

CMD ["/usr/local/bin/run"]