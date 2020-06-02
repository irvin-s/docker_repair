FROM sergeyzh/centos6-epel

MAINTAINER Sergey Zhukov, sergey@jetbrains.com

ADD vmware-tools.repo /etc/yum.repos.d/
RUN yum install -y vmware-tools-esx-nox

ADD scripts /etc/vmware-tools/scripts
RUN chmod -R +x /etc/vmware-tools/scripts/*

RUN sed -i "s/disable-tools-version=true/disable-tools-version=false/"  /etc/vmware-tools/tools.conf

ADD sbin /usr/sbin

ADD run-services.sh /
RUN chmod +x /run-services.sh

CMD /run-services.sh

