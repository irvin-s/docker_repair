# Dockerfile for building image that contains software stack provisioned by Ansible.
#
# Version  1.0
#


# pull base image
FROM williamyeh/ansible:centos7-onbuild

MAINTAINER William Yeh <william.pjyeh@gmail.com>


#
# build phase
#

RUN echo "===> Installing the missing "tar" utility for Docker image..."  && \
    yum -y install tar

ENV PLAYBOOK test.yml
RUN ansible-playbook-wrapper --extra-vars "prometheus_use_service=False prometheus_use_systemd=False"



#
# test phase
#

RUN echo "==> Removing PID files..."  && \
    rm -f /var/run/prometheus/*

RUN echo "===> Installing curl for testing purpose..."  && \
    yum -y install curl


VOLUME ["/data"]
ENV    RESULT     /data/result-centos7

CMD  \
     /etc/init.d/node_exporter start  &&  sleep 10  &&  \
     /etc/init.d/alertmanager start   &&  sleep 10  &&  \
     /etc/init.d/prometheus start     &&  sleep 60  &&  \
     curl --retry 5 --retry-max-time 120  http://localhost:9100/metrics  > $RESULT   && \
     curl --retry 5 --retry-max-time 120  http://localhost:9093/metrics  >> $RESULT  && \
     curl --retry 5 --retry-max-time 120  http://localhost:9090/metrics  >> $RESULT
