FROM centos:7

# Update Yum and install epel
RUN yum update -y && \
    yum install -y epel-release && \
    yum groupinstall -y development

# Install dependencies
RUN yum install -y \
    git \
    libevent \
    openssl-devel \
    unzip \
    wget \
    httpie \
    net-tools

# Install prerequisites for the Couchbase Server python SDK
# https://developer.couchbase.com/documentation/server/current/sdk/python/start-using-sdk.html
RUN wget http://packages.couchbase.com/releases/couchbase-release/couchbase-release-1.0-2-x86_64.rpm; \
    rpm -iv couchbase-release-1.0-2-x86_64.rpm; \
    yum install -y \
        libcouchbase-devel \
        gcc \
        gcc-c++ \
        python-devel \
        python-pip \
        sudo

RUN pip install --upgrade pip

# Install docker binary for docker in docker
RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.05.0-ce.tgz && \
    tar --strip-components=1 -xvzf docker-17.05.0-ce.tgz -C /usr/local/bin

WORKDIR /opt

# Git clone mobile-testkit
RUN git clone https://github.com/couchbaselabs/mobile-testkit.git

WORKDIR /opt/mobile-testkit

# Install dependencies
RUN pip install --ignore-installed -U ipaddress
RUN pip install --ignore-installed -U requests
RUN pip install -r requirements.txt

# Create ansible config for sample
RUN cp ansible.cfg.example ansible.cfg

# Set the correct default user
RUN sed -i 's/remote_user = vagrant/remote_user = root/' ansible.cfg

# set python env
ENV PYTHONPATH=/opt/mobile-testkit/
ENV ANSIBLE_CONFIG=/opt/mobile-testkit/ansible.cfg

# Cop test runner script to repo
COPY ./entrypoint.sh /opt/mobile-testkit
CMD ["/bin/bash"]
