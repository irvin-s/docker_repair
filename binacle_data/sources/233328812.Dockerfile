FROM postgres:10

COPY docker-entrypoint-initdb.d/init-db.sh /docker-entrypoint-initdb.d/
RUN localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8
ENV LANG ja_JP.utf8
