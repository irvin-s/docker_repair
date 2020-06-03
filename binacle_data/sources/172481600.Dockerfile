FROM  mysql:5.7

# Install database
ADD ./wlox.sql /docker-entrypoint-initdb.d/01_wlox.sql
ADD ./docker.sql /docker-entrypoint-initdb.d/02_docker.sql
ADD ./docker_db.sh /docker-entrypoint-initdb.d/03_dockerdb.sh
ADD ./docker_my.cnf /etc/mysql/conf.d/wlox.cnf

ENV MYSQL_RANDOM_ROOT_PASSWORD=yes
ENV MYSQL_DATABASE=wlox
ENV MYSQL_USER=wlox
ENV MYSQL_PASSWORD=wlox
