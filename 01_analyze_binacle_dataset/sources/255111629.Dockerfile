FROM ubuntu:16.04

COPY . /var/lib/stepler
WORKDIR /var/lib/stepler

RUN apt-get update -qq && \
    apt-get install -q -y \
    firefox=45.0.2+build1-0ubuntu1 \
    python-pip \
    libvirt-dev \
    xvfb \
    xdotool \
    git \
    libav-tools && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install -e .[libvirt]

COPY bin/run-tests.sh /usr/bin/run-tests
COPY bin/entrypoint.sh /usr/bin/entrypoint

ENV SOURCE_FILE /home/stepler/keystonercv3
ENV SKIP_LIST skip_list.yaml
ENV OPENRC_ACTIVATE_CMD "source /home/stepler/keystonercv3"
ENV VIRTUAL_DISPLAY 1
ENV OS_DASHBOARD_URL "http://172.16.10.90:8078"

#ENV ANSIBLE_SSH_ARGS='-C -o ControlMaster=no'

ENTRYPOINT ["/usr/bin/entrypoint"]

# Build
# docker build -t docker-ci-stepler:$(date "+%Y_%m_%d_%H_%M_%S")