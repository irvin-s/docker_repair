FROM registry.access.redhat.com/rhel7-atomic
# add libtool-ltdl
RUN microdnf install libtool-ltdl --enablerepo=rhel-7-server-rpms && \
    microdnf update; microdnf clean all

