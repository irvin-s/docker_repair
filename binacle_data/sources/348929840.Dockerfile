# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# Version  1.1
#


# pull base image
FROM williamyeh/ansible:debian8-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#

# install commands required in MongoDB installation package
RUN DEBIAN_FRONTEND=noninteractive  apt-get install -y adduser

ENV PLAYBOOK test.yml
RUN ansible-playbook-wrapper -vvv --extra-vars "nginx_use_service=False"

EXPOSE 27017


#
# test phase
#

RUN echo "===> Patch conf file to allow 0.0.0.0 and disable fork..."  && \
    sed -i -e 's/^\(\s*bind_ip\)/#--- \1/'  /etc/mongod.conf          && \
    sed -i -e 's/^\(\s*fork\)/#--- \1/'     /etc/mongod.conf


CMD ["mongod", "--config", "/etc/mongod.conf"]
