FROM centos:7
MAINTAINER Vincent Llorens <vincent.llorens@cc.in2p3.fr>
RUN yum install -y centos-release-openstack-newton \
                   git-core \
                   rpm-build \
                   python-devel \
                   python-setuptools \
    && yum update -y
RUN yum install -y python-pbr  # Needs centos-release-openstack-* to be installed first
RUN mkdir /tmp/synergy
RUN useradd -m -p pkger pkger
USER pkger
COPY build.sh /home/pkger/
WORKDIR /home/pkger/
CMD bash build.sh
