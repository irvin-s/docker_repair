FROM debian:8

MAINTAINER Pavel Trutman <pavel.trutman@fel.cvut.cz>

RUN apt-get update && \
    apt-get install -y apt-utils \
                       debconf-utils

# Git
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git

# Ansible
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y ansible

WORKDIR /root

# clone application
RUN git clone --depth 5 https://github.com/brmson/Personal-Assistant.git

# provision with ansible
RUN ansible-playbook -c local -i Personal-Assistant/deploy/ansible/docker_hosts Personal-Assistant/deploy/ansible/docker-web.yml

# expose HTTP
EXPOSE 80

# set entrypoint
CMD ["python3", "/root/web.py"]
