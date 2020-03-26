FROM postgres:9.6

ADD ./init-db.sh /docker-entrypoint-initdb.d/init-db.sh
RUN chmod a+x /docker-entrypoint-initdb.d/init-db.sh
