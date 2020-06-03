FROM centos:6
MAINTAINER https://github.com/JacobCallahan

ENV HOME /root
WORKDIR /root

RUN yum install -y wget
RUN wget https://copr.fedoraproject.org/coprs/dgoodwin/subscription-manager/repo/epel-6/dgoodwin-subscription-manager-epel-6.repo -O /etc/yum.repos.d/dgoodwin-subscription-manager-epel-6.repo
RUN yum install -y subscription-manager

ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh

EXPOSE 22

CMD /tmp/startup.sh
