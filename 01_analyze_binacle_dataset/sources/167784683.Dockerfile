FROM fedora:20
MAINTAINER "Moran Goldboim" <mgoldboi@redhat.com>
ENV container docker

#yum updates and needed RPMs
RUN yum -y update; \
yum -y install http://plain.resources.ovirt.org/pub/yum-repo/ovirt-release35.rpm; \
yum -y install net-tools openssh-server ovirt-engine wget systemd postgresql; \
yum clean all;

#systemd hack
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; \
do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
#RUN ln -s /lib/systemd/system/dbus.service /lib/systemd/system/basic.target.wants/dbus.service
RUN ln -s /lib/systemd/system/systemd-sysctl.service /lib/systemd/system/sysinit.target.wants/systemd-sysctl.service

#root password
RUN echo 'root:ovirt' | chpasswd;

#sshd enable
RUN /sbin/sshd-keygen
RUN systemctl enable sshd.service

#docker env config
EXPOSE 22 80 443 2049 32803 443 6100 662 80 875 892 111 32769 662 875 892

#VOLUME [ "/etc/ovirt-engine/", "/etc/sysconfig/ovirt-engine/", "/etc/exports.d/", "/etc/pki/ovirt-engine/", "/var/log/ovirt-engine/" ]

ENTRYPOINT ["/sbin/init"]

RUN echo 'root:ovirt' | chpasswd

