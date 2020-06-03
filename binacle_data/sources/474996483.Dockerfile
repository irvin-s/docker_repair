FROM registry.fedoraproject.org/fedora-minimal:27
LABEL maintainer="Micah Abbott <miabbott@redhat.com>" \
      summary="Tools container for use with atomic-host-tests" \
      url="https://github.com/projectatomic/atomic-host-tests" \
      usage="docker run -i miabbott/aht-tools"\
      version="1.0"
ENV container docker
COPY Dockerfile /root/
RUN microdnf install jq git python createrepo_c && \
    microdnf clean all
