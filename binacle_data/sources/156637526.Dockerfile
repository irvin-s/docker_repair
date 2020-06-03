FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"
ARG mysql_v="57"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN rpm -ivh http://repo.mysql.com/$(curl -s "https://dev.mysql.com/downloads/repo/yum/" |grep "noarch.rpm" |grep "$(awk '{print $4}' /etc/redhat-release |awk -F. '{print "el"$1}')" |grep -Po '(?<=\()[^)]*(?=\))')
RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/mysql-community.repo
RUN yum clean all; yum -y update; yum -y install net-tools bash-completion vim wget cronie at openssl iptables; yum --enablerepo=mysql$mysql_v-community install -y mysql-community-server; yum clean all

RUN mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

COPY mysql-rpm.sh /mysql.sh
COPY backup.sh /backup.sh
RUN chmod +x /*.sh

ENTRYPOINT ["/mysql.sh"]

EXPOSE 3306

CMD ["mysqld", "--user=mysql"]

# docker build --build-arg mysql_v=57 -t mysql-rpm:5.7 .
# docker run -d --restart always -p 3306:3306 -v /docker/mysql-rpm:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=newpass -e MYSQL_DATABASE=zabbix -e MYSQL_USER=zabbix -e MYSQL_PASSWORD=newpass -e MYSQL_BACK=Y --hostname mysql --name mysql mysql-rpm:5.7
# docker logs mysql |grep "PASSWORD"
# docker run -it --rm mysql-rpm --help
