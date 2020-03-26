FROM mysql:5.6

# enable utf8
RUN { \
    echo '[mysqld]'; \
    echo 'character-set-server = utf8'; \
} > /etc/mysql/conf.d/charset.cnf

# disable sql-mode
RUN { \
    echo '[mysqld]'; \
    echo 'sql_mode='; \
} > /etc/mysql/conf.d/sql_mode.cnf

# copy
COPY xxx.sql /setup.sql

# setupを追記したentrypoint
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
