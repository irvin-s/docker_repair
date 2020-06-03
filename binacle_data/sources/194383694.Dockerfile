FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD 1234
ENV MYSQL_PASSWORD password
ENV MYSQL_DATABASE databasename

# this need to stay the same for script to work
ENV MYSQL_USER mysql
