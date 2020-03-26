FROM registry.redhat.io/rhel7
# docker build . --build-arg RH_ORG_ID=...
# 12102058
ARG RH_ORG_ID 
# ocp
ARG RH_ACTIVATIONKEY
# 8a85f99c65c8c91b0166c4c52e2c2103
ARG RH_POOL_ID

RUN subscription-manager register --org=$RH_ORG_ID --activationkey=$RH_ACTIVATIONKEY  && \
    subscription-manager attach --pool=$RH_POOL_ID && \
    subscription-manager repos --disable="*" && \
    subscription-manager repos \
        --enable="rhel-7-server-rpms" \
        --enable="rhel-7-server-extras-rpms" \
        --enable="rhel-7-server-ose-3.11-rpms" \
        --enable="rhel-7-server-ansible-2.6-rpms"

RUN yum install -y skopeo openssl docker-distribution tmux lsof telnet

VOLUME /work
WORKDIR /work

ENTRYPOINT bash

USER 0
