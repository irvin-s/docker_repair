FROM {{BASE_IMAGE}}

RUN echo '\n\
[mysqld]\n\
datadir = /dev/shm/mysql\n\
' >> /etc/mysql/my.cnf
