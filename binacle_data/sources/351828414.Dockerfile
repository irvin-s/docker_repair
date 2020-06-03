FROM mysql:5.6

WORKDIR mysql

ADD guestbook.cnf /etc/mysql/conf.d/
