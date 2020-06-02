#
# MAINTAINER        Carson,C.J.Zeong <zcy@nicescale.com>
# DOCKER-VERSION    1.6.2
#
# Dockerizing Mariadb: Dockerfile for building Mariadb images
#
FROM index.alauda.cn/canyue/centos7_1
MAINTAINER Carson,C.J.Zeong <zcy@nicescale.com>

ENV DATA_DIR /var/lib/mysql

# Install Mariadb
RUN yum install -y mariadb mariadb-server && \
    yum clean all

ADD mysqld_charset.cnf /etc/my.cnf.d/

COPY scripts /scripts
RUN chmod +x /scripts/start

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/start"]
