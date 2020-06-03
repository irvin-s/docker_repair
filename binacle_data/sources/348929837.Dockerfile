# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# Version  1.1
#


# pull base image
FROM williamyeh/ansible:master-centos6-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#

ENV PLAYBOOK test.yml
RUN ansible-playbook-wrapper -vvv

EXPOSE 27017


#
# test phase
#

RUN echo "===> Patch conf file to allow 0.0.0.0 and disable fork..."  && \
    sed -i -e 's/^\(\s*bind_ip\)/#--- \1/'  /etc/mongod.conf          && \
    sed -i -e 's/^\(\s*fork\)/#--- \1/'     /etc/mongod.conf


CMD ["mongod", "--config", "/etc/mongod.conf"]
