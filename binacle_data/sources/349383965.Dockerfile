FROM centos
MAINTAINER openshift-qe

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy

RUN yum install -y squid
RUN chgrp root /var/spool/squid /var/log/squid /var/run /etc/squid/squid.conf
RUN chmod g+rwx /var/spool/squid /var/log/squid /var/run
RUN chmod g+r /etc/squid/squid.conf
ADD htpasswd squid_auth.conf /etc/squid/
ADD entrypoint.sh /sbin/

EXPOSE 3128/tcp
VOLUME ["${SQUID_CACHE_DIR}"]
ENTRYPOINT ["/sbin/entrypoint.sh"]

