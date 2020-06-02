FROM orcidhub/app

LABEL maintainer="The University of Auckland" \
	description="NZ ORCiD Hub Application Image with Development support"

COPY dev_requirements.txt /dev_requirements.txt
COPY requirements.txt /requirements.txt
COPY run-app /usr/local/bin/

RUN yum -y update \
    && yum -y install  install https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-redhat96-9.6-3.noarch.rpm \
    && yum -y install \
            gcc.x86_64 \
            postgresql96 \
            python36u-devel.x86_64 \
            python36u-pip \
            git \
    && pip3.6 install -U pip \
    && pip install -U -r /dev_requirements.txt \
    && cd /var/lib/rpm \
    && rm -rf __db* \
    && rpm --rebuilddb \
    && yum -y clean all \
    && rm -rf /var/cache/yum \
    && rm -rf $HOME/.pip/cache \
    && rm -rf /var/cache/*/* /anaconda-post.log /dev_requirements.txt /requirements.txt


ENV DEBUG=1
WORKDIR /src
