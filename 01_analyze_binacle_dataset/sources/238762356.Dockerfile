FROM mariadb:10

RUN mkdir /data
WORKDIR /data

# Download database dump
RUN apt-get update && apt-get install -y curl && \
    curl -O https://ghtstorage.blob.core.windows.net/downloads/msr14-mysql.gz

# Configure it to work with the database we will create
RUN echo 'CREATE DATABASE msr14; USE msr14;' > 02-msr14-mysql.sql && \
    gunzip -c msr14-mysql.gz >> 02-msr14-mysql.sql && \
    mv 02-msr14-mysql.sql /docker-entrypoint-initdb.d/msr-mysql.sql

EXPOSE 3306

# Run the database
CMD ["/usr/bin/mysqld"]