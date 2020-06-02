# KaveToolbox 3.7-Beta on centos 7
FROM centos:7
MAINTAINER KAVE <kave@kpmg.com>
RUN yum clean all
RUN yum -y install wget curl python python-devel
RUN wget http://repos:kaverepos@repos.dna.kpmglab.com/noarch/KaveToolbox/3.7-Beta/kavetoolbox-installer-3.7-Beta.sh
RUN /bin/bash kavetoolbox-installer-3.7-Beta.sh --node
