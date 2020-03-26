#######################################################################################
#
# Dockerfile for a container building pyGATB wheels that are compatible on most linux.
# For usage, see the docker/build-manylinux.sh script in the parent directory.
#
#######################################################################################

# ###
#     Base commands
#
#     We use a manylinux docker image, which is a CentOS 5 with many CPython
#     version installed.
#
FROM quay.io/pypa/manylinux1_x86_64:latest

# who to blame?
LABEL mainteners="Patrick Durand <patrick.durand@inria.fr>; Maël Kerbiriou <mael.kerbiriou@free.fr>"

# How many (make) jobs to run in parallel ?
ENV PARALLEL_OPT="-j4"

# Build time scripts
COPY install-cmake.sh /tmp/

# ###
#     Build Dependencies
#

# Install library dependencies
RUN yum install -y zlib-devel \
 && yum clean all \
# Install CMake
 && /tmp/install-cmake.sh 3.7.2 \
 && rm /tmp/install-cmake.sh \
# Install cython
 && /opt/python/cp36-cp36m/bin/pip install --no-cache cython \
 && cp /opt/python/cp36-cp36m/bin/cython /usr/local/bin/

CMD ["build"]
COPY build-manylinux.sh /usr/local/bin/build
