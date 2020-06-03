FROM williamyeh/ansible:ubuntu14.04

WORKDIR /tmp
COPY  ansible  /tmp

# ==> Creating inventory file...
RUN echo localhost > inventory

# ==> Executing Ansible...
RUN ansible-playbook -i inventory amon-agent.yml --connection=local


RUN cat /etc/amon-agent.conf
