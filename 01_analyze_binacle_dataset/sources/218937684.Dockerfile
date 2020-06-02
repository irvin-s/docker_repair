FROM ubuntu:14.04

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git htop man unzip vim wget && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
  rm -rf /var/lib/apt/lists/* && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

ADD my.cnf /etc/mysql/my.cnf
ADD setup_database.sh /
ADD *.sql /
RUN chmod +x /setup_database.sh

VOLUME ["/etc/mysql", "/var/lib/mysql", "/var/log"]

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["mysqld_safe"]

CMD /bin/bash /setup_database.sh

# Expose ports.
EXPOSE 3306
