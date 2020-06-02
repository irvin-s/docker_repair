#
# MAINTAINER          Max
# DOCKER-VERSION      1.10
# UBUNTU-VERSION      14.04
# LNMP-VERSION        1.2 www.lnmp.org
# Dockerfile-VERSION  3.0
# DATE                11/07/2016
#

FROM ubuntu:14.04
MAINTAINER Max

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD sources.list /etc/apt/sources.list

# Update
# RUN apt-get -y update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install wget tar screen htop passwd nano openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Download and install lnmp1.2.
RUN wget -c ftp://soft.vpser.net/lnmp/lnmp1.2-full.tar.gz && tar zxf lnmp1.2-full.tar.gz -C root && rm -rf lnmp1.2-full.tar.gz

ADD ubuntu.sh /root/lnmp1.2-full/ubuntu.sh
ADD main-ubuntu.sh /root/lnmp1.2-full/include/main-ubuntu.sh
ADD version-ubuntu.sh /root/lnmp1.2-full/include/version-ubuntu.sh
RUN chmod +x /root/lnmp1.2-full/ubuntu.sh
RUN cd /root/lnmp1.2-full && \   
    ./ubuntu.sh lamp

RUN cd /root/lnmp1.2-full/src && \
    rm -rf `ls -I patch`

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**
ENV ROOT_PASS LNMP123

VOLUME ["/home"]

EXPOSE 80 
EXPOSE 21 
EXPOSE 22 
EXPOSE 3306 
EXPOSE 6379 
EXPOSE 11211

CMD ["/run.sh"]
