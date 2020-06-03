FROM centos:5
MAINTAINER https://github.com/JacobCallahan

ENV HOME /root
WORKDIR /root

ADD subman.repo /etc/yum.repos.d/
RUN install -Dv /dev/null /var/cache/yum/base/mirrorlist.txt && \
    install -Dv /dev/null /var/cache/yum/extras/mirrorlist.txt && \
    install -Dv /dev/null /var/cache/yum/updates/mirrorlist.txt && \
    install -Dv /dev/null /var/cache/yum/libselinux/mirrorlist.txt
RUN echo "http://vault.centos.org/5.11/os/x86_64/" > /var/cache/yum/base/mirrorlist.txt && \
    echo "http://vault.centos.org/5.11/extras/x86_64/" > /var/cache/yum/extras/mirrorlist.txt && \
    echo "http://vault.centos.org/5.11/updates/x86_64/" > /var/cache/yum/updates/mirrorlist.txt && \
    echo "http://vault.centos.org/5.11/centosplus/x86_64/" > /var/cache/yum/libselinux/mirrorlist.txt
RUN yum install -y subscription-manager

ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh

EXPOSE 22

CMD /tmp/startup.sh
