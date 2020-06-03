FROM postgres:9

ADD initdb.sql /docker-entrypoint-initdb.d/
