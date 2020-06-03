FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install build-essential -y

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections

RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

RUN apt install mysql-server -y

RUN usermod -d /var/lib/mysql/ mysql

RUN mkdir /var/run/mysqld

ADD ./runMySQL.sh /runMySQL.sh

RUN chmod +x /runMySQL.sh

RUN apt-get install curl -y

RUN curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh

RUN chmod +x nodesource_setup.sh 

RUN ./nodesource_setup.sh

RUN apt-get install -y nodejs

RUN apt-get install -y git-core