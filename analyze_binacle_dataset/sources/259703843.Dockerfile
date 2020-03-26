FROM mariadb/columnstore:1.2
#rebuild mariadb/columnstore

COPY ./single_node /docker-entrypoint-initdb.d