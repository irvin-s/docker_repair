FROM xeor/base:7.1-6

RUN rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/7/x86_64/zabbix-release-2.4-1.el7.noarch.rpm && \
    yum install -y zabbix-web-pgsql zabbix-server-pgsql zabbix-get && \
    mkdir /etc/zabbix.d

# A little anoying, but for some reason (that is hopefully fixed in 3.x), the rpm package doesnt contain
# database setup files. We need them initially.
RUN mkdir /tmp/zabbix && curl -L http://repo.zabbix.com/zabbix/2.4/rhel/7/SRPMS/zabbix-2.4.7-1.el7.src.rpm > /tmp/zabbix/src.rpm && \
    cd /tmp/zabbix && rpm2cpio src.rpm | cpio -idmv --no-absolute-filenames && tar -zxvf zabbix-*.tar.gz && mv zabbix-*/database/postgresql/ /usr/share/doc/zabbix-server-pgsql*/

COPY zabbix.conf /etc/zabbix/zabbix_server.conf
COPY zabbix-web.conf /etc/zabbix/web/zabbix.conf.php
COPY httpd-zabbix.conf /etc/httpd/conf.d/zabbix.conf

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/
