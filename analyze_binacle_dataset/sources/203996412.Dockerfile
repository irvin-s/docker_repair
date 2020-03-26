FROM jacknlliu/ubuntu-init:16.04

LABEL maintainer="Jack Liu <jacknlliu@gmail.com>"

# copy scripts file
RUN mkdir -p /opt/scripts/container/ && chmod -R a+rx /opt/scripts/
COPY ./scripts/*.sh /opt/scripts/container/
RUN chmod a+rwx -R /opt/scripts/container && sync && cd /opt/scripts/container && ./install_vr_support.sh

# aptitude clean
RUN apt-get autoclean \
    && apt-get clean all \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*
