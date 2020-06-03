# playbook2image
FROM rhscl/python-27-rhel7:2.7

MAINTAINER OpenShift Team <dev@lists.openshift.redhat.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Ansible playbook to image builder" \
      io.k8s.display-name="playbook2image" \
      io.openshift.tags="builder,ansible,playbook" \
      io.openshift.expose-services="" \
      url="https://github.com/openshift/playbook2image/blob/master/README.md" \
      name="openshift3/playbook2image" \
      summary="Ansible playbook to image builder" \
      description="Base image to to ship Ansible playbooks as self-executing container image." \
      atomic.run="once" \
      com.redhat.component="playbook2image-docker" \
      vcs-url="https://github.com/openshift/playbook2image" \
      vcs-type="git" \
      version="0.0.1"

# Install Ansible.
#
# The default Dockerfile also installs 'pip' and 'python-devel' so that the
# builder image can install Python dependencies if the playbooks need them.  In
# the productized version these are provided by the python-27-rhel7 base image,
# and dependencies should be packaged and installed with yum instead
USER root

# To use a subscription inside container yum command has to be run first (before
# yum-config-manager) https://access.redhat.com/solutions/1443553
RUN yum repolist > /dev/null && \
    yum-config-manager --enable rhel-7-server-ose-3.6-rpms && \
    yum install -y --setopt=tsflags=nodocs ansible && \
    yum clean all -y

COPY ./.s2i/bin/ /usr/libexec/s2i
COPY user_setup /tmp
COPY system-container/exports /exports

ENV APP_ROOT=/opt/app-root
ENV USER_NAME=default \
    USER_UID=1001 \
    APP_HOME=${APP_ROOT}/src \
    HOME=${APP_ROOT}/src \
    PATH=$PATH:${APP_ROOT}/bin

RUN mkdir -p ${APP_HOME} ${APP_ROOT}/etc ${APP_ROOT}/bin
RUN chmod -R ug+x ${APP_ROOT}/bin ${APP_ROOT}/etc /tmp/user_setup && \
    /tmp/user_setup

# Back to the UID used in the base image
USER ${USER_UID}

RUN sed "s@${USER_NAME}:x:${USER_UID}:0@${USER_NAME}:x:\${USER_ID}:\${GROUP_ID}@g" /etc/passwd > ${APP_ROOT}/etc/passwd.template

WORKDIR ${APP_HOME}

CMD ["/usr/libexec/s2i/usage"]
