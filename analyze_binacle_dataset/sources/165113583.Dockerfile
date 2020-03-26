FROM mysql:5.7.22

ENV MYSQL_ROOT_PASSWORD omp
ENV MYSQL_USER omp
ENV MYSQL_PASSWORD omp

COPY ./init.sh /docker-entrypoint-initdb.d/
COPY ./schema /schema
