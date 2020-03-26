FROM quay.io/openshiftio/rhel-base-pcp:latest

LABEL maintainer "Devtools <devtools@redhat.com>"
LABEL author "Devtools <devtools@redhat.com>"
ENV LANG=en_US.utf8
ENV AUTH_INSTALL_PREFIX=/usr/local/auth

# Create a non-root user and a group with the same name: "auth"
ENV AUTH_USER_NAME=auth
RUN useradd --no-create-home -s /bin/bash ${AUTH_USER_NAME}

COPY bin/auth ${AUTH_INSTALL_PREFIX}/bin/auth
COPY config.yaml ${AUTH_INSTALL_PREFIX}/etc/config.yaml

COPY ./auth+pmcd.sh /auth+pmcd.sh
EXPOSE 44321

# From here onwards, any RUN, CMD, or ENTRYPOINT will be run under the following user
USER ${AUTH_USER_NAME}

WORKDIR ${AUTH_INSTALL_PREFIX}
ENTRYPOINT [ "/auth+pmcd.sh" ]

EXPOSE 8089
