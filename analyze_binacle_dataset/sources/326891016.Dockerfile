FROM docker.io/openshift/origin-ansible:v3.11

MAINTAINER OpenShift Team <dev@lists.openshift.redhat.com>

USER root

LABEL com.redhat.component="maistra-ansible-container"
LABEL name="maistra/openshift-ansible"
LABEL summary="Red Hat Istio Ansible Installer OpenShift container image"
LABEL description="Red Hat Istio Ansible Installer OpenShift container image"
LABEL io.k8s.display-name="Red Hat Istio Ansible Installer"
LABEL io.k8s.description="Red Hat Istio Ansible Installer OpenShift container image"
LABEL io.openshift.expose-services=""
LABEL io.openshift.tags="istio"
LABEL maintainer="Istio Feedback <istio-feedback@redhat.com>"
LABEL atomic.run="once"
LABEL version="0.10.0"

RUN INSTALL_PKGS="iproute" \
 && yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS \
 && yum clean all

COPY roles/installer_checkpoint/callback_plugins/installer_checkpoint.py ${WORK_DIR}/roles/installer_checkpoint/callback_plugins/
COPY playbooks/openshift-istio/ ${WORK_DIR}/playbooks/openshift-istio/
COPY roles/openshift_istio/ ${WORK_DIR}/roles/openshift_istio/

USER ${USER_UID}
