FROM centos:centos7

MAINTAINER Lars Solberg <lars.solberg@gmail.com>

RUN yum localinstall -y http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm

RUN yum install -y curl wget tmux tar unzip \
                   iputils iproute net-tools bind-utils nmap nc iptraf-ng mtr tcpdump

ADD start /start
RUN chmod +x /start
ENTRYPOINT ["/start"]
CMD ["bash"]
