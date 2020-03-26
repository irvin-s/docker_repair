FROM centos/systemd

MAINTAINER "Seth Rosetter" <seth.rosetter@gmail.com>

RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install sudo \ 
        initscripts \
        ngrep \
        git \
        unzip \
        net-tools \
        less \
        httpie 

CMD ["/usr/sbin/init"]
