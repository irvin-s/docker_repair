FROM centos:7
MAINTAINER https://github.com/JacobCallahan

ENV HOME /root
WORKDIR /root

RUN yum install -y subscription-manager

ADD startup.sh /tmp/
RUN chmod +x /tmp/startup.sh

EXPOSE 22

CMD /tmp/startup.sh
