FROM centos:6

RUN yum update -y && yum install rpm-build make tar python-setuptools git epel-release -y
RUN yum update -y && yum install python-pip -y
RUN pip install argparse

COPY ./build-rpms.sh /
