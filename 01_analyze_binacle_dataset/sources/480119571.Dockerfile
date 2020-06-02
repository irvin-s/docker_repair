#
# MAINTAINER          Max
# DOCKER-VERSION      3.00
# CENTOS-VERSION      6.7
# LNMP-VERSION        1.4 www.lnmp.org
# Dockerfile-VERSION  1.0
# DATE                01/05/2018
#

FROM centos:6.7
MAINTAINER Max

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD aliyun-mirror.repo /etc/yum.repos.d/CentOS-Base.repo
ADD aliyun-epel.repo /etc/yum.repos.d/epel.repo

RUN yum -y install wget tar screen htop passwd nano openssh-server vsftpd pwgen && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_dsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

# Download and install lnmp1.4.
RUN wget -c http://soft.vpser.net/lnmp/lnmp1.4.tar.gz && tar zxf lnmp1.4.tar.gz -C root && rm -rf lnmp1.4.tar.gz

ADD main.sh /root/lnmp1.4/include/main.sh
ADD end.sh /root/lnmp1.4/include/end.sh
RUN chmod +x /root/lnmp1.4/install.sh
RUN cd /root/lnmp1.4 && \   
    ./install.sh
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS LNMP123

VOLUME ["/home"]

EXPOSE 80 21 22 3306 6379 11211

CMD ["/run.sh"]
