
FROM untoldwind/dose:base-v3

RUN apt-get install -y mysql-server

ADD sources/consul /etc/consul.d
RUN mkdir -p /etc/consul-templates
ADD sources/consul-templates /etc/consul-templates
ADD sources/supervisor /etc/supervisor/conf.d
ADD sources/my.cnf /etc/mysql/my.cnf
ADD sources/init.sql /tmp/init.sql

EXPOSE 22 3306

CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
