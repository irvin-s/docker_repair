FROM mysql:5.7

# add our custom config file
ADD small_memory_defaults.cnf /etc/mysql/conf.d

COPY *.dump.sql /docker-entrypoint-initdb.d/
