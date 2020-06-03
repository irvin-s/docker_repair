FROM ansibleplaybookbundle/apb-base

COPY playbooks /opt/apb/actions
COPY roles /opt/ansible/roles
RUN  yum -y install python-pip && pip install pymssql && yum clean all -y
RUN chmod -R g=u /opt/{ansible,apb}
ENV ANSIBLE_ROLES_PATH /etc/ansible/roles:/opt/ansible/roles
USER apb
ENTRYPOINT /bin/bash
