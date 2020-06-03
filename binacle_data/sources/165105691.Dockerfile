# My devbox Docker image.
#
# VERSION 0.0.1

from debian:jessie

maintainer Nicolas Carlier <https://github.com/ncarlier>

env DEBIAN_FRONTEND noninteractive

# Install Ansible
run apt-get update && \
    apt-get install -y openssh-client ansible && \
    apt-get clean

# Add playbooks to the Docker image
copy provisioning /provisioning
workdir /provisioning

# Run Ansible to configure the Docker image
run ansible-playbook headless.yml -i inventory/docker

# Setup shared volume
volume /var/shared

# Setup working directory
workdir /home/dev

# Run everything below as the dev user
user dev

# Setup dev user environment
env HOME /home/dev
env PATH $HOME/bin:$PATH
env LANG fr_FR.UTF-8
env LANGUAGE fr_FR:fr
env LC_ALL fr_FR.UTF-8

entrypoint ["/usr/bin/ssh-agent", "/bin/zsh"]
