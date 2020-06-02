FROM centos:centos7
MAINTAINER weitao zhou <wtzhou@dataman-inc.com>

RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Copy only files required for the following RUN commands (leverage Docker caching)
COPY container-files/etc/yum.repos.d/* /etc/yum.repos.d/

RUN \
    yum update -y && \
    yum install -y epel-release && \
    yum install -y MariaDB-server MariaDB-client hostname net-tools pwgen && \
    yum clean all && \
    rm -rf /var/lib/mysql/*

# Add all remaining files to the container
COPY container-files /
ENV WSREP_CLUSTER_ADDRESS ""

# Add VOLUME to allow backup of data
VOLUME ["/var/lib/mysql"]

# Set TERM env to avoid mysql client error message "TERM environment variable not set" when running from inside the container
ENV TERM xterm

EXPOSE 3306 4567 4568 4444

CMD ["/run.sh"]
