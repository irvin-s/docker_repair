FROM centos:centos7
MAINTAINER diego.uribe.gamez@gmail.com

RUN yum -y update

RUN yum -y install epel-release
RUN yum -y install gcc gcc-c++
RUN yum -y install mariadb mariadb-devel MySQL-python

RUN yum -y install python-devel python-setuptools python-pip
RUN pip install --upgrade pip

RUN yum clean all

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt
RUN rm -f /tmp/requirements.txt
