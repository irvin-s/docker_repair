FROM ubuntu:18.04

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		build-essential \
		python-dev \
		python-pip \
    software-properties-common \
    git \
	&& \
	pip install dumb-init && \
	apt-get remove -y \
		build-essential \
		python-dev \
		python-pip \
	&& \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:


RUN \
  apt-add-repository -y ppa:ansible/ansible && \
  apt-get update && \
  apt-get install -y ansible

# Install Ansible inventory file
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

ENTRYPOINT dumb-init python -c 'while True: pass'
