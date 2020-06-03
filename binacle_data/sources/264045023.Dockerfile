FROM mysql:5.6

# add our custom config file
ADD small_memory_defaults.cnf /etc/mysql/conf.d

COPY *.sql /docker-entrypoint-initdb.d/
