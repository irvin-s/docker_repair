# playbook2image
FROM openshift/base-centos7

MAINTAINER OpenShift Team <dev@lists.openshift.redhat.com>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Ansible playbook to image builder" \
      io.k8s.display-name="playbook2image" \
      io.openshift.tags="builder,ansible,playbook" \
      url="https://github.com/openshift/playbook2image/blob/master/README.md" \
      name="openshift/playbook2image" \
      summary="Ansible playbook to image builder" \
      description="Base image to to ship Ansible playbooks as self-executing container image." \
      atomic.run="once" \
      vcs-url="https://github.com/openshift/playbook2image" \
      vcs-type="git" \
      version="alpha"

# ansible and pip are in EPEL
RUN yum install -y epel-release && yum clean all -y

RUN yum install -y  --setopt=tsflags=nodocs ansible python-pip python-devel && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
#COPY ./<builder_folder>/ /opt/app-root/

COPY ./.s2i/bin/ /usr/libexec/s2i
COPY user_setup /tmp
COPY system-container/exports /exports
ADD README.md /help.1

ENV APP_ROOT=/opt/app-root
ENV USER_NAME=default \
    USER_UID=1001 \
    APP_HOME=${APP_ROOT}/src \
    PATH=$PATH:${APP_ROOT}/bin
RUN mkdir -p ${APP_HOME} ${APP_ROOT}/etc ${APP_ROOT}/bin
RUN chmod -R ug+x ${APP_ROOT}/bin ${APP_ROOT}/etc /tmp/user_setup && \
    /tmp/user_setup

# This default user is created in the openshift/base-centos7 image
USER ${USER_UID}

RUN sed "s@${USER_NAME}:x:${USER_UID}:0@${USER_NAME}:x:\${USER_ID}:\${GROUP_ID}@g" /etc/passwd > ${APP_ROOT}/etc/passwd.template
CMD ["/usr/libexec/s2i/usage"]
