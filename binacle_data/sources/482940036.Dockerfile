# docker build --rm -t nvidia-352.99 .

FROM lipcomputing/ansible-ubuntu16.04
MAINTAINER Mario David <mariojmdavid@gmail.com>
LABEL description="NVIDIA GPU" \
      org.label-schema.vcs-url="https://github.com/LIP-Computing/ansible-role-nvidia"

RUN ansible-galaxy install LIP-Computing.ansible-role-nvidia && \
    ansible-playbook --extra-vars "nv=352.99" /etc/ansible/roles/LIP-Computing.ansible-role-nvidia/tests/install-docker.yml
