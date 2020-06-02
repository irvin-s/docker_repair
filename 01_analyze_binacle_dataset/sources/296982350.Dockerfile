FROM mysql:5.7

LABEL Description="Production MySQL database for TaskService"

ADD encoding.cnf /etc/mysql/conf.d/





