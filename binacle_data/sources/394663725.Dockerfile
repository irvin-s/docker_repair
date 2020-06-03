FROM fcoelho/python27
MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

RUN yum install -y http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum install -y --enablerepo=centosplus 389-ds && yum clean all
# We backup dirsrv directories because volumes will replace them when the
# container is started. During the first run, this will be copied back to the
# correct location to populate the volumes
RUN mkdir /backup && cp -r /etc/dirsrv /backup/etc-dirsrv && cp -r /usr/share/dirsrv /backup/usr-share-dirsrv

ADD ds-setup.inf /tmp/ds-setup.inf
ADD run.sh /run.sh
ADD supervisord.conf /etc/supervisord.conf

VOLUME ["/var/lib/dirsrv", "/etc/dirsrv", "/var/log/dirsrv", "/var/lock/dirsrv", "/usr/share/dirsrv"]

EXPOSE 389 9830

CMD ["/run.sh"]

#/usr/sbin/ns-slapd -D /etc/dirsrv/slapd-ldap -i /var/run/dirsrv/slapd-ldap.pid -w /var/run/dirsrv/slapd-ldap.startpid
#/usr/sbin/httpd.worker -k start -f /etc/dirsrv/admin-serv/httpd.conf
