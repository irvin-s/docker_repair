FROM centos:7

MAINTAINER Nitish Krishna nitishk@juniper.net

COPY docker/cobbler/entrypoint.sh /

# Copy our custom cobbler configs
COPY src/cobbler/etc_cobbler/* /etc/cobbler/
COPY src/cobbler/var_lib_cobbler/* /var/lib/cobbler/
COPY src/cobbler/python_cobbler/* /usr/lib/python2.7/dist-packages/cobbler/modules/
COPY src/cobbler/etc_bind/named.conf.options /etc/named/
COPY src/cobbler/etc_cobbler/tftpd.template /etc/xinetd.d/tftp

# Configure systemd
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install dependent packages
#RUN yum -y install epel-release
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum -y install cobbler \
                   cobbler-web \
                   systemd \
                   dhcp \
                   bind \
                   syslinux \
                   pykickstart \
                   initscripts \
                   net-tools \
                   file \
                   fence-agents \
                   tftp \
                   tftp-server \
                   xinetd

# Create required folders
RUN mkdir -p /etc/httpd/sites-available /etc/httpd/sites-enabled

COPY src/contrail_smgr/smgr.conf /etc/httpd/sites-enabled/
RUN echo 'IncludeOptional sites-enabled/*.conf' >> /etc/httpd/conf/httpd.conf

# Enable required packages
RUN systemctl enable cobblerd
RUN systemctl enable httpd
RUN systemctl enable dhcpd
RUN systemctl enable xinetd
RUN systemctl enable tftp
RUN chkconfig tftp on

# Mount common volumes
VOLUME [ "/usr/bin/", \
         "/sys/fs/cgroup/", \
         "/usr/lib/systemd/system/", \
         "/etc/cobbler/", \
         "/usr/share/cobbler/", \
         "/var/lib/cobbler/", \
         "/var/log/cobbler/", \
         "/var/www/cobbler_webui_content/", \
         "/var/www/cobbler/", \
         "/etc/httpd/", \
         "/usr/lib/python2.7/site-packages/cobbler/", \
         "/usr/lib/python2.7/dist-packages/cobbler/", \
         "/etc/xinetd.d/", \
         "/var/lib/tftpboot" ]

# Expose the ports for Cobbler/Httpd/DHCPD APIs
EXPOSE 80
EXPOSE 443
EXPOSE 25151
EXPOSE 69/udp
EXPOSE 49152-49160/udp

ENTRYPOINT ["bash", "entrypoint.sh"]
CMD ["/sbin/init"]
