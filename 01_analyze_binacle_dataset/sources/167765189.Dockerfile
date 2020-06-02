# https://registry.hub.docker.com/u/evgenyg/ansible/

FROM ubuntu:14.04.2
ADD  docker /docker
RUN         /docker/ansible/install-ansible.sh
CMD  [ "/bin/bash" ]
