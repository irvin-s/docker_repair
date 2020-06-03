# Ansible "server"
FROM silarsis/ssh-server
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -yq install python-software-properties; \
  add-apt-repository ppa:rquillo/ansible -y; \
  apt-get -yq update; \
  apt-get -yq install ansible

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
