FROM centos:centos6

MAINTAINER Lars Solberg <lars.solberg@gmail.com>

RUN yum install -y python-2.6.6 python-setuptools
RUN easy_install pip

ADD requirements.txt /requirements.txt
RUN pip2.6 install -r /requirements.txt

CMD ["ipython"]

