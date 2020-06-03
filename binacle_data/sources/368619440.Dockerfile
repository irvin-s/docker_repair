FROM ubuntu:16.04

ARG MYSQL_ROOT_PWD
RUN test -n "$MYSQL_ROOT_PWD"

ARG MYSQL_APP_USER
ARG MYSQL_APP_PWD
RUN test -n "$MYSQL_APP_USER"
RUN test -n "$MYSQL_APP_PWD"

RUN echo "mysql-server-5.7 mysql-server/root_password password ${MYSQL_ROOT_PWD}" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password ${MYSQL_ROOT_PWD}" | debconf-set-selections
  
RUN apt-get update && apt-get install -y \
    apache2 \
    autoconf \
    autotools-dev \
    build-essential \
    curl \
    cmake \
    git \
    libapache2-mod-wsgi \
    libmysqlclient-dev \
    libssl-dev \
    mysql-client \
    mysql-server \
    python \
    python-pip \
    python-setuptools

RUN ls -ahl $HOME

COPY . /srv/encore

RUN mkdir /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    service mysql start && \
    mysql -uroot -p${MYSQL_ROOT_PWD} < /srv/encore/schema.sql && \
    mysql -u root -p${MYSQL_ROOT_PWD} -e "CREATE USER '"${MYSQL_APP_USER}"'@'localhost' IDENTIFIED BY '"${MYSQL_APP_PWD}"'" && \
    mysql -u root -p${MYSQL_ROOT_PWD} -e "GRANT DELETE, INSERT, SELECT, UPDATE, EXECUTE ON encore.*  TO '"${MYSQL_APP_USER}"'@'localhost'"

RUN mkdir /srv/encore/build
WORKDIR /srv/encore/build
RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN make

WORKDIR /srv/encore
RUN pip install -r requirements.txt

RUN ln -s /srv/encore/encore.conf.example /etc/apache2/sites-enabled/encore.conf

EXPOSE 3306/tcp
EXPOSE 80/tcp
EXPOSE 443/tcp

# https://serverfault.com/questions/870568/fatal-error-cant-open-and-lock-privilege-tables-table-storage-engine-for-use/892896#892896
CMD find /var/lib/mysql -type f -exec touch {} \;; apachectl -DFOREGROUND & mysqld_safe & wait
