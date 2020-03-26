FROM registry.access.redhat.com/rhel7:7.4-129
MAINTAINER Student <student@example.com>

# Deps for mariadb
RUN yum -y install --disablerepo "*" --enablerepo rhel-7-server-rpms \
      mariadb-server openssl psmisc net-tools hostname && \
    yum clean all

# Add set up scripts
ADD scripts /scripts
RUN chmod 755 /scripts/* && \
    MARIADB_DIRS="/var/lib/mysql /var/log/mariadb /run/mariadb" && \
    chown -R mysql:0 ${MARIADB_DIRS} && \
    chmod -R g=u ${MARIADB_DIRS}

EXPOSE 3306
VOLUME /var/lib/mysql /var/log/mariadb /run/mariadb
USER mysql
CMD ["/bin/bash", "/scripts/start.sh"]
