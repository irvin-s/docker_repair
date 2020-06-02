FROM mysql:latest

MAINTAINER Haydar KÜLEKCİ <haydarkulekci@gmail.com>

# !!!!!! FOR DEVELOPMENT ENVIRONMENT !!!!!!
RUN echo "[mysqld]\nskip-grant-tables" >> /etc/mysql/my.cnf

CMD ["mysqld"]

EXPOSE 3306
