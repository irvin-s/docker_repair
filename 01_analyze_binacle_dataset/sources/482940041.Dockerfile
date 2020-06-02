# docker build --rm -t nvidia-384.90 .

FROM lipcomputing/ansible-ubuntu16.04
MAINTAINER Mario David <mariojmdavid@gmail.com>
LABEL description="NVIDIA GPU" \
      org.label-schema.vcs-url="https://github.com/LIP-Computing/ansible-role-nvidia"

RUN ansible-galaxy install LIP-Computing.ansible-role-nvidia && \
    ansible-playbook --extra-vars "nv=384.90" /etc/ansible/roles/LIP-Computing.ansible-role-nvidia/tests/install-docker.yml
