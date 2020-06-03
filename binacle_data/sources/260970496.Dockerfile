FROM centos:latest

RUN yum -y update;


# mariadb 
RUN yum -y install mariadb mariadb-server;
RUN systemctl enable mariadb;


# redis
RUN yum -y install epel-release;
RUN yum -y install redis;
RUN systemctl enable redis;


# others
RUN yum install -y libuuid-devel openssl-devel mariadb-devel apr-util-devel protobuf-lite-devel


# supervisor
RUN yum install -y supervisor
RUN systemctl enable supervisord

COPY ./supervisor_confs/*.ini /etc/supervisord.d/

RUN yum clean all;
RUN mkdir -p /opt/im_server

CMD ["/usr/sbin/init"]
