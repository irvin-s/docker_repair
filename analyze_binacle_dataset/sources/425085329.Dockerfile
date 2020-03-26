# Ansible (gewo/ansible)
FROM gewo/python
MAINTAINER Gebhard Wöstemeyer <g.woestemeyer@gmail.com>

RUN apt-get update &&\
  apt-get install -y libyaml-dev libgmp-dev &&\
  apt-get clean
RUN pip install ansible
CMD ["/bin/bash"]
