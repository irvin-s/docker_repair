# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# Version  1.0
#


# pull base image
FROM williamyeh/ansible:centos6-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#

RUN echo "===> Installing the missing "tar" utility for Docker image..."  && \
    yum -y install tar

ENV PLAYBOOK test.yml
RUN ansible-playbook-wrapper



#
# test phase
#

VOLUME ["/data"]
ENV    RESULT     /data/result-centos6

CMD \
    service monit start  &&  sleep 10  && \
    /usr/bin/monit status  > $RESULT