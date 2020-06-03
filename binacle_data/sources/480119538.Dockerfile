#
# MAINTAINER          Max
# DOCKER-VERSION      2.00
# CENTOS-VERSION      6.7
# LNMP-VERSION        1.3 www.lnmp.org
# Dockerfile-VERSION  1.0
# DATE                10/31/2016
#

FROM centos:6.7
MAINTAINER Max

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD aliyun-mirror.repo /etc/yum.repos.d/CentOS-Base.repo
ADD aliyun-epel.repo /etc/yum.repos.d/epel.repo

# Update
# RUN yum -y update

RUN yum -y install wget tar screen htop passwd nano openssh-server vsftpd pwgen && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_dsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

# Download and install lnmp1.3.
RUN wget -c http://maxwhale.cn/download/lnmp1.3-full.tar.gz && tar zxf lnmp1.3-full.tar.gz -C root && rm -rf lnmp1.3-full.tar.gz

ADD install.sh /root/lnmp1.3-full/install.sh
ADD main.sh /root/lnmp1.3-full/include/main.sh
ADD version.sh /root/lnmp1.3-full/include/version.sh
RUN chmod +x /root/lnmp1.3-full/install.sh
RUN cd /root/lnmp1.3-full && \   
    ./install.sh lnmp

RUN cd /root/lnmp1.3-full/src && \
    rm -rf `ls -I patch`

ADD php-fpm.conf /usr/local/php/etc/php-fpm.conf
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS LNMP123

VOLUME ["/home"]

EXPOSE 80 21 22 3306 6379 11211

CMD ["/run.sh"]
