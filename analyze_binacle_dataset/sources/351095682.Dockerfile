# Dockerfile for building image that contains software stack provisioned by Ansible.
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

VOLUME ["/data"]
ENV    RESULT     /data/result-debian7

CMD \
    service monit start  &&  sleep 10  && \
    /usr/bin/monit status  > $RESULT