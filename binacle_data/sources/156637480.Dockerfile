FROM centos:latest
MAINTAINER "The CentOS Project" <admin@jiobxn.com>
ARG LATEST="0"
ARG mysql_v="57"

RUN \cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN rpm -ivh "https://www.percona.com$(curl -s https://www.percona.com/downloads/percona-release/redhat/latest/ |grep noarch.rpm |awk -F\" '{print $12}')"
RUN yum clean all; yum -y update; yum -y install net-tools bash-completion vim wget cronie at openssl iptables; yum install -y Percona-XtraDB-Cluster-${mysql_v}; yum clean all
RUN rm -rf /var/lib/mysql/*

RUN mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

COPY mysql-pxc.sh /mysql.sh
COPY backup.sh /backup.sh
RUN chmod +x /*.sh

ENTRYPOINT ["/mysql.sh"]

EXPOSE 3306 4567 4568 4444

CMD ["mysqld_safe", "--basedir=/usr"]

# docker build --build-arg mysql_v=57 -t mysql-pxc:5.7 .
# docker run -d --restart always --network=mynetwork --ip=10.0.0.61 -v /docker/pxc1:/var/lib/mysql -e REPL_IPR=10.0.0.% -e MYSQL_ROOT_PASSWORD=newpass -e PXC_ADDRESS="10.0.0.61,10.0.0.62,10.0.0.63" -e XPC_INIT=Y --hostname pxc1 --name pxc1 mysql-pxc:5.7
# docker run -d --restart always --network=mynetwork --ip=10.0.0.62 -v /docker/pxc2:/var/lib/mysql -e PXC_ADDRESS="10.0.0.61,10.0.0.62,10.0.0.63" --hostname pxc2 --name pxc2 mysql-pxc:5.7
# docker run -d --restart always --network=mynetwork --ip=10.0.0.63 -v /docker/pxc3:/var/lib/mysql -e PXC_ADDRESS="10.0.0.61,10.0.0.62,10.0.0.63" --hostname pxc3 --name pxc3 mysql-pxc:5.7
# docker logs pxc1 |grep "PASSWORD"
# docker run -it --rm mysql-pxc1 --help
