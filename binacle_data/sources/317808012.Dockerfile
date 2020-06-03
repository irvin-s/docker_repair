FROM mysql:5.7
ENV TZ=Asia/Shanghai
COPY ./my.cnf /etc/mysql/conf.d/
