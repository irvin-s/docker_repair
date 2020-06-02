FROM centos:7

# packages should be installed with docs
RUN sed -i -e "s/tsflags=nodocs/#tsflags=nodocs/g" /etc/yum.conf

ENV container docker
RUN yum -y update; yum clean all

RUN yum -y install selinux-policy passwd vim tar wget && yum clean all

# set the initial root password so that you can login with docker attach
RUN echo root:root | chpasswd

# disable SELINUX
RUN sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

WORKDIR /root
RUN wget -O kolabscripts.tar.gz https://github.com/TBits/KolabScripts/archive/master.tar.gz; tar xzf kolabscripts.tar.gz; rm -f kolabscripts.tar.gz
WORKDIR /root/KolabScripts-master/kolab
# we want to install the kolab packages in a separate step
RUN sed -i -e "s/yum -y install kolab/#yum -y install kolab/" reinstallCentOS.sh
RUN echo "y" | ./reinstallCentOS.sh CentOS_7

# TODO: modify the next command to rebuild the package. eg echo "packages from 2016-03-22" && ...
RUN yum -y install kolab kolab-freebusy && yum clean all

# prepare for setup kolab
RUN sed -i -e "s/systemctl start guam/#systemctl start guam/g" initSetupKolabPatches.sh && ./initSetupKolabPatches.sh
# we cannot run setup-kolab here, because systemd is not running yet
#RUN setup-kolab --default -mysqlserver=new --timezone=Europe/Brussels --directory-manager-pwd=test
#RUN ./initHttpTunnel.sh
#RUN ./initSSL.sh test.example.org

VOLUME [ "/sys/fs/cgroup" ]

# allow connections on port 443 (https)
EXPOSE 443

ENTRYPOINT ["/usr/sbin/init"]

