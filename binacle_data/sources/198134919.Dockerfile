FROM debian:9

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		build-essential \
		python \
		python-dev \
		python-pip \
	&& \
	pip install dumb-init ansible && \
	apt-get remove -y \
		build-essential \
		python-dev \
		python-pip \
	&& \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

# Install Ansible inventory file
RUN mkdir -p /etc/ansible \
    && echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

ENTRYPOINT dumb-init python -c 'while True: pass'
