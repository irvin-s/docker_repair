FROM postgres:9.4

ADD files/10-conf.sh /docker-entrypoint-initdb.d/10-conf.sh
ADD files/20-nuxeodb.sql /docker-entrypoint-initdb.d/20-nuxeodb.sql
ADD files/30-create-quartz-tables.sh /docker-entrypoint-initdb.d/30-create-quartz-tables.sh
ADD files/30-create-quartz-tables.sql /30-create-quartz-tables.sql