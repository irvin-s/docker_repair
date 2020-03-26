FROM debian:stretch

LABEL name="jasonheecs/ansible:debian-9"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3015
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -my wget gnupg && \
    echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee /etc/apt/sources.list.d/ansible.list           && \
    echo "deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/ansible.list    && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367    && \
    DEBIAN_FRONTEND=noninteractive  apt-get update && apt-get install -y --no-install-recommends \
        ansible \
        fonts-lato \
        javascript-common \
        libjs-jquery \
        libruby \
        rake \
        ruby \
        ruby-minitest \
        ruby-test-unit \
        rubygems-integration \
        unzip \
        zip && \
    rm -rf /var/lib/apt/lists/*  /etc/apt/sources.list.d/ansible.list && \
    gem install bundler && \
    gem cleanup all

CMD [ "ansible-playbook", "--version" ]