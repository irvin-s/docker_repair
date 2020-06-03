FROM centos:7

MAINTAINER PubNative <pubnative-backend@pubnative.net>

RUN yum update -y
RUN yum install -y https://github.com/sysown/proxysql/releases/download/v2.0.3/proxysql-2.0.3-1-centos7.x86_64.rpm

EXPOSE 3306 6032

CMD proxysql -f -c /etc/proxysql.cnf
