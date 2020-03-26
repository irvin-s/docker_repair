#
# NethServer Docker demo
#

FROM centos:latest

EXPOSE 980

ADD root/ /srv/root
RUN useradd -G adm -r srvmgr && \
    chown -c -R root:root /srv/root && \
    yum -y install yum-utils epel-release patch && \
    yum -y --disablerepo=* localinstall http://mirror.nethserver.org/nethserver/nethserver-release-7.rpm && \
    rpm --import /etc/pki/rpm-gpg/* && \
    yum -y install \
                    sudo rsync python-simplejson \
                    perl perl-Text-Template perl-Sys-Syslog perl-JSON perl-Authen-PAM perl-LDAP perl-Net-DNS \
                    httpd mod_ssl \
                    mod_php php-xml php-soap php-intl

RUN /srv/root/build-docker-demo && \
    rsync -aiI /srv/root/ /

ENTRYPOINT ["/run.sh"]

