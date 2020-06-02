# KaveToolbox 3.7-Beta on ubuntu 14
FROM ubuntu:14.04
MAINTAINER KAVE <kave@kpmg.com>
RUN apt-get update
RUN apt-get install -y wget curl
RUN apt-get install -y python python-dev
RUN wget http://repos:kaverepos@repos.dna.kpmglab.com/noarch/KaveToolbox/3.7-Beta/kavetoolbox-installer-3.7-Beta.sh
RUN /bin/bash kavetoolbox-installer-3.7-Beta.sh --node
