
# - Percona Server Dockerfile
# -
# -
# - https://github.com/dockerfile/percona

FROM ubuntu:latest

ENV MYSQL_ROOT_PASSWORD 93bdfe5ea84a66d73f3874aa793dc77f0676d67e
# ENV MYSQL_ALLOW_EMPTY_PASSWORD

ENV MYSQL_USER dbadmin
ENV MYSQL_PASSWORD dbadminpass
ENV MYSQL_DATABASE mortis_data

ENV DB_DATA mortis_data
ENV DB_USER node_process
ENV DB_PASS 93bdfe5ea84a66d73f3874aa793dc77f0676d67e

# Install Percona Server.
RUN apt-get update                                                                                          && \
    apt-get install -y --no-install-recommends wget                                                         && \
    wget https://repo.percona.com/apt/percona-release_0.1-4.xenial_all.deb --no-check-certificate           && \
    dpkg -i percona-release_0.1-4.xenial_all.deb                                                            && \
    apt-get update                                                                                          && \
    apt-get install -y percona-server-server-5.7                                                            && \
    sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf                                                && \
    sed -i 's/.*bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/percona-server.conf.d/mysqld.cnf         && \
    sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf                                                   && \
    echo "mysqld_safe &"                                                                     > /tmp/config  && \
    echo "mysqladmin --silent --wait=30 ping || exit 1"                                     >> /tmp/config  && \
    echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'"      >> /tmp/config  && \
    echo "mysql -e 'CREATE USER \"$DB_USER\"@\"%\" IDENTIFIED BY \"$DB_PASS\";'"            >> /tmp/config  && \
    echo "mysql -e 'GRANT SUPER ON *.* TO \"$DB_USER\"@\"%\" IDENTIFIED BY \"$DB_PASS\";'"  >> /tmp/config  && \
    echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"$DB_USER\"@\"%\";'"                    >> /tmp/config  && \
    echo "mysql -e 'CREATE DATABASE $DB_DATA;'"                                             >> /tmp/config  && \
    echo "mysql -e 'GRANT ALL PRIVILEGES ON $DB_DATA.* TO \"$DB_USER\"@\"%\";'"             >> /tmp/config  && \
    bash /tmp/config                                                                                        && \
    rm -f /tmp/config

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["mysqld_safe"]

# Expose ports.
EXPOSE 3306