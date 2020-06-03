FROM centos:centos7

MAINTAINER Aaron Weitekamp <aweiteka@redhat.com>

RUN echo -e "[epel]\nname=epel\nenabled=1\nbaseurl=https://dl.fedoraproject.org/pub/epel/7/x86_64/\ngpgcheck=0" > /etc/yum.repos.d/epel.repo

RUN yum install -y --setopt=tsflags=nodocs python-pip python-devel gcc docker git npm nmap-ncat && \
    yum clean all

ADD ctf_cli/ /opt/ctf/ctf_cli/
ADD ctf-cli.py requirements.txt LICENSE README.md /opt/ctf/
ADD tests.conf.sample /opt/ctf/tests.conf

WORKDIR /opt/ctf

RUN pip install -r requirements.txt

RUN git clone https://github.com/Containers-Testing-Framework/common-steps.git --depth 1
RUN git clone https://github.com/Containers-Testing-Framework/common-features.git --depth 1
RUN ln -s /opt/ctf/ctf-cli.py /usr/bin/ctf-cli

WORKDIR /opt
RUN npm install git+https://github.com/projectatomic/dockerfile_lint && \
    ln -s /opt/node_modules/dockerfile_lint/bin/dockerfile_lint /usr/bin/dockerfile_lint

WORKDIR /root/ctf-tests
LABEL RUN docker run -it --rm --privileged -v `pwd`:/root/ctf-tests -v /run:/run -v /:/host --name NAME -e NAME=NAME -e IMAGE=IMAGE IMAGE

CMD /bin/bash

