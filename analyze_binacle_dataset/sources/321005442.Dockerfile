#Copyright (c) 2018 VMware, Inc. All Rights Reserved.
#
#SPDX-License-Identifier: MIT
FROM ubuntu:16.04

ENV GOVC=https://github.com/vmware/govmomi/releases/download/v0.18.0/govc_linux_amd64.gz
ENV OVA=https://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64.ova
ENV ANSIBLE_HOST_KEY_CHECKING=False

RUN apt-get -qq update && apt-get install -y \
		curl \
		jq \
		git \
		openssh-server \
		python-pip \
		sudo && \
    curl -L $GOVC | gunzip > /usr/bin/govc && chmod +x /usr/bin/govc && \
	useradd -ms /bin/bash vmware && \
	pip install 'ansible<2.6' && \
	echo 'vmware ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/vmware

COPY . /home/vmware
RUN chown -R vmware:vmware /home/vmware

# This isn't really needed for purely testing the automation
# ADD $OVA /bootstrap.ova

RUN mkdir -p /deployroot
WORKDIR /home/vmware/provision
USER vmware

RUN ansible-galaxy install -r external_roles.yml && \
	ssh-keygen -f ~/.ssh/id_rsa.test -t rsa -N '' && \
	echo "---" > ~/.ansible/roles/concourse/tasks/kernel_update.yml

CMD ["-vv", "-e", "do_download=false", "-e", "ansible_ssh_user=root", \
"-e", "ansible_ssh_private_key_file=~/.ssh/id_rsa.test", \
"-e", "bootstrap_box_ip=localhost", \
"-e", "deploy_user=vmware", \
"site.yml", "-i", "inventory"]
ENTRYPOINT [ "ansible-playbook" ]
