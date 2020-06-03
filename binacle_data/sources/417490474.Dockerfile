FROM redis:3.2

ADD import.sql /docker-entrypoint-initdb.d/
