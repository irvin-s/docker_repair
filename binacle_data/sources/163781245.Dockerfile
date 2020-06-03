FROM lenz/whaleware

EXPOSE 5038 8088

RUN \
 yum install -y wget mlocate dnsmasq nano mc && \
 yum localinstall -y http://packages.asterisk.org/centos/6/current/i386/RPMS/asterisknow-version-3.0.1-2_centos6.noarch.rpm && \
 yum update -y asterisknow-version 

RUN yum install -y asterisk asterisk-configs --enablerepo=asterisk-11

ADD ./ww /ww

