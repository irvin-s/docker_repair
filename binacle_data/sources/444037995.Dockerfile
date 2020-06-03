FROM xeor/base:7.1-4

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2014-10-03

RUN yum install -y wget unzip par2cmdline python-cheetah python-configobj python-feedparser pyOpenSSL python-setuptools && \
    yum localinstall -y http://pkgs.repoforge.org/unrar/unrar-5.0.3-1.el7.rf.x86_64.rpm

RUN wget https://github.com/sabnzbd/sabnzbd/archive/0.7.18.zip -O sabnzbd.zip && unzip sabnzbd.zip && mv sabnzbd-* sabnzbd

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/
