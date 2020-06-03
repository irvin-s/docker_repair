FROM centos:centos6
MAINTAINER Toni Pizà <tpiza@habitissimo.com>

ENV NODE_PATH /srv/mitro/browser-ext/api/build/node/lib/node_modules

RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN yum install -y postgresql
RUN yum install -y postgresql-contrib
RUN yum install -y npm.noarch
RUN yum install -y git
RUN yum install -y ant
RUN yum install -y ant-nodeps
RUN yum install -y java-1.7.0-openjdk-devel.x86_64

RUN yum install -y xz
RUN yum install -y wget
RUN yum install -y tar
RUN yum install -y unzip
RUN yum install -y bzip2
RUN npm -g install npm

RUN yum install -y python-setuptools
RUN easy_install argparse

# mitro expects the keys to be in this dir
RUN mkdir -p /mitrocore_secrets/sign_keyczar

WORKDIR /srv/mitro
RUN git clone https://github.com/mitro-co/mitro.git /srv/mitro

# apply browser-ext patch and static files patch
COPY ./lru_patch.diff /srv/mitro/
COPY ./static_files.diff /srv/mitro/
RUN git apply lru_patch.diff
RUN git apply static_files.diff

# add static files
RUN mkdir /html
COPY templates/verified.html /html/

WORKDIR /srv/mitro/mitro-core

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ant", "server"]
