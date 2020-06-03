FROM centos:7
LABEL maintainer "Devtools <devtools@redhat.com>"
LABEL author "Konrad Kleine <kkleine@redhat.com>"
ENV LANG=en_US.utf8
ENV AUTH_INSTALL_PREFIX=/usr/local/auth

# Create a non-root user and a group with the same name: "auth"
ENV AUTH_USER_NAME=auth
RUN useradd --no-create-home -s /bin/bash ${AUTH_USER_NAME}

COPY bin/auth ${AUTH_INSTALL_PREFIX}/bin/auth
COPY config.yaml ${AUTH_INSTALL_PREFIX}/etc/config.yaml

# Install little pcp pmcd server for metrics collection
# would prefer only pmcd, and not the /bin/pm*tools etc.
COPY pcp.repo /etc/yum.repos.d/pcp.repo
RUN yum install -y pcp pcp-pmda-prometheus && yum clean all && \
    mkdir -p /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp  && \
    chgrp -R root /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp && \
    chmod -R g+rwX /etc/pcp /var/run/pcp /var/lib/pcp /var/log/pcp
COPY ./auth+pmcd.sh /auth+pmcd.sh
EXPOSE 44321


# From here onwards, any RUN, CMD, or ENTRYPOINT will be run under the following user
USER ${AUTH_USER_NAME}

WORKDIR ${AUTH_INSTALL_PREFIX}
ENTRYPOINT [ "/auth+pmcd.sh" ]

EXPOSE 8089
