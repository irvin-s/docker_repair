FROM andrewrothstein/docker-ansible:centos_7
MAINTAINER Andrew Rothstein <andrew.rothstein@gmail.com>

ADD . /playbook
WORKDIR /playbook
RUN ansible-playbook test.yml
