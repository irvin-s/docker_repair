# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# USAGE:
#   $ docker build .
#
# Version  1.0
#


# pull base image
FROM williamyeh/ansible:debian7-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#

ENV PLAYBOOK test.yml
RUN ansible-playbook-wrapper



#
# test phase
#

CMD ["node", "--version"]
