# docker build --rm -t nvidia-sshd-ubuntu16.04 .

FROM indigodatacloud/ubuntu-sshd:16.04
LABEL description="NVIDIA GPU" \
      org.label-schema.vcs-url="https://github.com/LIP-Computing/ansible-role-nvidia"

RUN ansible-galaxy install LIP-Computing.ansible-role-nvidia && \
    ansible-playbook --extra-vars "nv=375.20" /etc/ansible/roles/LIP-Computing.ansible-role-nvidia/tests/install-docker.yml

EXPOSE 22
CMD    /etc/init.d/vmcontext start; /usr/sbin/sshd -D
