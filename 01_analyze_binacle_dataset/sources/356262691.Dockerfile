FROM jeqo/centos-7

MAINTAINER Jorge Quilcate <quilcate.jorge@gmail.com>

ADD . /srv/ansible-playbooks
WORKDIR /srv/ansible-playbooks

RUN ansible-playbook test-install-oracle-java-8-66-centos-7.yml -c local

CMD ["/bin/bash", "echo $JAVA_HOME"]
